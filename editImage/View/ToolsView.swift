import SwiftUI
import UIKit

struct ToolsView: View {
    @Binding var selectedImage: UIImage?
    @State private var navigateToPolynomialAdjustment = false

    var body: some View {
        VStack(spacing: 0) {
            // Image Preview (Centered)
            GeometryReader { geometry in
                VStack {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    } else {
                        Text("No image selected")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Center within GeometryReader
            }
            .padding()

            // Tools Toolbar
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
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
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
                )
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            }
        }
    }

    func toolButton(title: String, systemImage: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: systemImage)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.primary)
            Text(title)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .frame(width: 60, height: 60)
        .background(
            Circle()
                .fill(Color.gray.opacity(0.2))
                .shadow(radius: 2)
        )
        .contentShape(Circle())
    }
}
