import SwiftUI

struct TuneImageView: View {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var controller: TuneImageController

    init(image: Binding<UIImage?>) {
        _image = image
        if let img = image.wrappedValue {
            _controller = StateObject(wrappedValue: TuneImageController(image: img))
        } else {
            _controller = StateObject(wrappedValue: TuneImageController(image: UIImage()))
        }
    }

    var body: some View {
        VStack {
            if let adjustedImage = controller.model.adjustedImage {
                Image(uiImage: adjustedImage)
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("Loading image...")
                    .foregroundColor(.gray)
                    .font(.headline)
            }

            Spacer()

            VStack {
                Text("Smoothness").foregroundColor(.black)
                Slider(value: $controller.model.smoothness, in: 0...2, onEditingChanged: { _ in
                    controller.applyFilters()
                })

                Text("Sharpness").foregroundColor(.black)
                Slider(value: $controller.model.sharpness, in: 0...2, onEditingChanged: { _ in
                    controller.applyFilters()
                })
            }
            .padding()

            Button("Apply") {
                image = controller.model.adjustedImage
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}

