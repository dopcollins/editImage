//
//  TextOverlayController.swift
//  editImage
//
//  Created by Collins Roy on 19/03/25.
//


import Foundation
import UIKit

class TextOverlayController: ObservableObject {
    @Published var model: TextOverlayModel

    init(image: UIImage) {
        self.model = TextOverlayModel(originalImage: image)
    }

    func applyTextOverlay() {
        let renderer = UIGraphicsImageRenderer(size: model.originalImage.size)
        let newImage = renderer.image { context in
            model.originalImage.draw(in: CGRect(origin: .zero, size: model.originalImage.size))

            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 40),
                .foregroundColor: UIColor.black
            ]
            let textRect = CGRect(
                x: model.textPosition.x,
                y: model.textPosition.y,
                width: model.originalImage.size.width,
                height: 50
            )
            model.text.draw(in: textRect, withAttributes: attributes)
        }
        model.editedImage = newImage
    }
}
