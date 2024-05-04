//
//  ContentView.swift
//  ShadowMaster
//
//  Created by WanSen on 26/04/24.
//

import SwiftUI


struct ContentView: View {
    @State private var showContent = false
    var body: some View {
        if showContent {
            HomeView()
                .transition(.opacity)
        }
        else{
            SplashScreen()
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    showContent = true
                }
                
            }
        }

    }
}

#Preview {
    ContentView()
}
