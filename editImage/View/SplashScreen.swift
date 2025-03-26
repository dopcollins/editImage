//
//  SplashScreen.swift
//  editImage
//
//  Created by Collins Roy on 22/02/25.
//

import Foundation
import Foundation
import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var scale: CGFloat = 0.5
    @State private var showMainView = false
    
    var body: some View {
        if showMainView {
            ContentView()
        } else {
            ZStack {
                Color.white.ignoresSafeArea()
                
                Image("launch1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                    .opacity(isActive ? 0 : 1)
                    .offset(x: 1, y: -10)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 2.5)) {
                            isActive = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showMainView = true
                        }
                    }
            }
        }
    }
}
