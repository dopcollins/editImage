//
//  DrawOnImageModel.swift
//  editImage
//
//  Created by Collins Roy on 19/03/25.
//

import UIKit
import PencilKit

struct DrawingModel {
    var image: UIImage?
    var drawing: PKDrawing = PKDrawing()
    
    mutating func updateDrawing(_ newDrawing: PKDrawing) {
        drawing = newDrawing
    }
    
    func combinedImage(size: CGSize) -> UIImage? {
        guard let image = image else { return nil }
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        image.draw(in: CGRect(origin: .zero, size: size))
        drawing.image(from: CGRect(origin: .zero, size: size), scale: UIScreen.main.scale).draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
