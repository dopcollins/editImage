import SwiftUI
import UIKit

struct ToolsView: View {
    @Binding var selectedImage: UIImage?
    @State private var navigateToPolynomialAdjustment = false

    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding()
            } else {
                Text("No image selected")
                    .foregroundColor(.gray)
                    .font(.headline)
            }

            Spacer()

            HStack(spacing: 15) {
                NavigationLink(destination: CropView(image: $selectedImage)) {
                    toolButton(title: "Crop", systemImage: "crop")
                }

                NavigationLink(destination: DetailsView(image: $selectedImage)) {
                    toolButton(title: "Details", systemImage: "slider.horizontal.3")
                }
                
                NavigationLink(destination: TuneImageView(image: $selectedImage)) {
                    toolButton(title: "Tune", systemImage: "slider.horizontal.below.square.filled.and.square")
                }
                
                NavigationLink(destination: DrawOnImageView(selectedImage: $selectedImage)) {
                    toolButton(title: "Draw", systemImage: "pencil.tip.crop.circle")
                }
                
                NavigationLink(destination: TextOverlayView(selectedImage: $selectedImage)) {
                    toolButton(title: "Text", systemImage: "textformat")
                }
            }
            .padding()
        }
    }

    func toolButton(title: String, systemImage: String) -> some View {
        VStack {
            Image(systemName: systemImage)
                .font(.system(size: 24))
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 80, height: 80)
        .background(Color.gray)
        .cornerRadius(10)
    }
}
