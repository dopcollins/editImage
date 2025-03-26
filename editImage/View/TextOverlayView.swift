//
//  File.swift
//  editImage
//
//  Created by Collins Roy on 19/03/25.
//

import SwiftUI

struct TextOverlayView: View {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var controller: TextOverlayController

    init(selectedImage: Binding<UIImage?>) {
        _selectedImage = selectedImage
        if let img = selectedImage.wrappedValue {
            _controller = StateObject(wrappedValue: TextOverlayController(image: img))
        } else {
            _controller = StateObject(wrappedValue: TextOverlayController(image: UIImage()))
        }
    }

    var body: some View {
        VStack {
            if let img = controller.model.editedImage ?? selectedImage {
                ZStack {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)

                    Text(controller.model.text)
                        .font(.largeTitle)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .offset(x: controller.model.textPosition.x, y: controller.model.textPosition.y)
                        .gesture(DragGesture().onChanged { value in
                            controller.model.textPosition.x += value.translation.width
                            controller.model.textPosition.y += value.translation.height
                        })
                }
            } else {
                Text("No image available")
                    .foregroundColor(.gray)
                    .font(.headline)
            }

            TextField("Enter text", text: $controller.model.text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            HStack {
                Button("Apply") {
                    controller.applyTextOverlay()
                    selectedImage = controller.model.editedImage
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
        }
    }
}
