//
//  DataModel.swift
//  ShadowMaster
//
//  Created by WanSen on 29/04/24.
//

import Foundation
import SwiftUI

class DataModel: ObservableObject {
    
    @Published var items: [Item] = []
    
    init() {
        if let documentDirectory = FileManager.default.documentDirectory {
            let urls = FileManager.default.getContentsOfDirectory(documentDirectory).filter { $0.isImage }
            for url in urls {
                let item = Item(url: url)
                items.append(item)
            }
        }
        
        if let urls = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: nil) {
            for url in urls {
                let item = Item(url: url)
                items.append(item)
            }
        }
    }
    
    /// Adds an item to the data collection.
    func addItem(_ item: Item) {
        items.insert(item, at: 0)
    }
    
    /// Removes an item from the data collection.
    func removeItem(_ item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            FileManager.default.removeItemFromDocumentDirectory(url: item.url)
        }
    }
}


extension URL {
    /// Indicates whether the URL has a file extension corresponding to a common image format.
    var isImage: Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "heic"]
        return imageExtensions.contains(self.pathExtension)
    }
}


func handleCameraPhotos() async {
    let unpackedPhotoStream = camera.photoStream
        .compactMap { self.unpackPhoto($0) }
    
    for await photoData in unpackedPhotoStream {
        Task { @MainActor in
            thumbnailImage = photoData.thumbnailImage
        }
        savePhoto(imageData: photoData.imageData)
    }
}

private func unpackPhoto(_ photo: AVCapturePhoto) -> PhotoData? {
    guard let imageData = photo.fileDataRepresentation() else { return nil }


    guard let previewCGImage = photo.previewCGImageRepresentation(),
       let metadataOrientation = photo.metadata[String(kCGImagePropertyOrientation)] as? UInt32,
          let cgImageOrientation = CGImagePropertyOrientation(rawValue: metadataOrientation) else { return nil }
    let imageOrientation = Image.Orientation(cgImageOrientation)
    let thumbnailImage = Image(decorative: previewCGImage, scale: 1, orientation: imageOrientation)
    
    let photoDimensions = photo.resolvedSettings.photoDimensions
    let imageSize = (width: Int(photoDimensions.width), height: Int(photoDimensions.height))
    let previewDimensions = photo.resolvedSettings.previewDimensions
    let thumbnailSize = (width: Int(previewDimensions.width), height: Int(previewDimensions.height))
    
    return PhotoData(thumbnailImage: thumbnailImage, thumbnailSize: thumbnailSize, imageData: imageData, imageSize: imageSize)
}

func savePhoto(imageData: Data) {
    Task {
        do {
            try await photoCollection.addImage(imageData)
            logger.debug("Added image data to photo collection.")
        } catch let error {
            logger.error("Failed to add image to photo collection: \(error.localizedDescription)")
        }
    }
}
