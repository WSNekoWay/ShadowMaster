//
//  HomeView.swift
//  ShadowMaster
//
//  Created by WanSen on 26/04/24.
//


import SwiftUI
import CoreML

struct HomeView: View {
    @State private var isIdentifyEnabled = true
    @State private var isModelSheetPresented = false
    @State private var openImagePicker = false
    @State private var openImageCamera = false
    @State private var openImageLibrary = false
    @State private var imageSelected = UIImage()
    @State private var sourceType: UIImagePickerController.SourceType?
    
    @StateObject private var icViewModel = WayangViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Let's Get To Know Wayang!")
                .bold()
                .font(.system(size: 24))
                .padding()

            ZStack(alignment: .topLeading) {
                Rectangle()
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, dash: [10]))
                    .frame(width: 320, height: 410)

                Button(action: {
                    openImagePicker = true
                }, label: {
                    if imageSelected.size != .zero{
                        Image(uiImage: imageSelected)
                            .resizable()
                            .frame(width: 280, height: 373)
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    } else {
                        ZStack() {
                            Rectangle()
                                .stroke(Color.clear)
                                .frame(width: 280, height: 373)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))

                            VStack {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .frame(width: 80, height: 108)
                                    .foregroundColor(.blue)
                                Text("Upload Image")
                                    .bold()
                                    .foregroundColor(.blue)
                                    .font(.system(size: 16))
                                    .padding()
                            }
                        }

                    }
                })
                if imageSelected.size != .zero{
                    Image(systemName: "pencil")
                        .frame(width: 36, height:36)
                        .foregroundColor(.blue)
                        .background(Color.white)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                        )
                        .clipShape(Circle())
                        .padding(EdgeInsets(top: 8, leading: 276, bottom: 0, trailing: 0))
                }
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 200, trailing: 0))

            Button(action: {
                icViewModel.ShadowMasterModel(uiImage: imageSelected)
                isModelSheetPresented = true
               
            }) {
                Text("Identify")
                    .bold()
                    .frame(width: 320, height: 28)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding()
                    .background(isIdentifyEnabled ? Color.blue : Color.gray)
                    .cornerRadius(10)
            }
            .actionSheet(isPresented: $openImagePicker) {
                ActionSheet(title: Text("Choose Image Source"), buttons: [
                    .default(Text("Take Photo")) {
                        sourceType = .camera
                        openImageCamera = true
                    },
                    .default(Text("Choose from Library")) {
                        sourceType = .photoLibrary
                        openImageLibrary = true
                    },
                    .cancel()
                ])
            }
            .sheet(isPresented: $openImageCamera){
                ImagePicker(selectedImage: $imageSelected, sourceType: .camera)
            }
            .sheet(isPresented: $openImageLibrary){
                ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
            }
            
            .sheet(isPresented: $isModelSheetPresented) {
                if let firstText = icViewModel.imageClassificationText.first {
                    let secondText = icViewModel.imageClassificationText.indices.contains(1) ? icViewModel.imageClassificationText[1] : ""
                    let thirdText = icViewModel.imageClassificationText.indices.contains(2) ? icViewModel.imageClassificationText[2] : ""
                    
                    let prob1 = icViewModel.imageClassificationProb.indices.contains(0) ? icViewModel.imageClassificationProb[0] : 0.0
                    let prob2 = icViewModel.imageClassificationProb.indices.contains(1) ? icViewModel.imageClassificationProb[1] : 0.0
                    let prob3 = icViewModel.imageClassificationProb.indices.contains(2) ? icViewModel.imageClassificationProb[2] : 0.0
                    
                    let model = WayangModel(
                        title: firstText,
                        second: secondText,
                        third: thirdText,
                        prob1: prob1,
                        prob2: prob2,
                        prob3: prob3
                    )
                    WayangView(model: model)
                } else {
                    WayangView(model: WayangModel(title: "", second: "", third: "", prob1: 0.0, prob2: 0.0, prob3: 0.0))
                }
            }

            .disabled(!isIdentifyEnabled)
            .padding(.bottom)
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
