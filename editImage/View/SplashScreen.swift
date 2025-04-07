import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var showMainView = false
    
    var body: some View {
        Group {
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
                        .offset(x: 0, y: -10)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.5)) {
                                isActive = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                showMainView = true
                            }
                        }
                }
            }
        }
    }
}
