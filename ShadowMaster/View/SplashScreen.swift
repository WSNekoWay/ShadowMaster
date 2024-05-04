//
//  SplashScreen.swift
//  ShadowMaster
//
//  Created by WanSen on 26/04/24.
//

import Foundation
import SwiftUI

struct SplashScreen: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Image(getLogoImageName())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 256, height: 256)
            
            Text("Shadow Master")
                .font(.system(size: 36))
                .bold()
                .padding(EdgeInsets(top: -48, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(EdgeInsets(top: -160, leading: 0, bottom: 0, trailing: 0))
    }
    
    func getLogoImageName() -> String {
        return colorScheme == .dark ? "Dark_Logo" : "Logo"
    }
}


#Preview {
    SplashScreen()
}
