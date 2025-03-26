//
//  TuneImageController.swift
//  editImage
//
//  Created by Collins Roy on 19/03/25.
//

import Foundation
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class TuneImageController: ObservableObject {
    @Published var model: TuneImageModel
    private let context = CIContext()

    init(image: UIImage) {
        self.model = TuneImageModel(originalImage: image)
        applyFilters()  // ✅ Apply filters immediately
    }

    func applyFilters() {
        guard let ciImage = CIImage(image: model.originalImage) else { return }
        
        // Apply Smoothness (Softens image using Gaussian Blur)
        let smoothnessFilter = CIFilter.gaussianBlur()
        smoothnessFilter.inputImage = ciImage
        smoothnessFilter.radius = Float(model.smoothness * 10)

        // Apply Sharpness (Unsharp Mask)
        let sharpnessFilter = CIFilter.unsharpMask()
        sharpnessFilter.inputImage = smoothnessFilter.outputImage
        sharpnessFilter.radius = Float(model.sharpness * 2.5)
        sharpnessFilter.intensity = Float(model.sharpness)

        if let outputImage = sharpnessFilter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            DispatchQueue.main.async {
                self.model.adjustedImage = UIImage(
                    cgImage: cgImage,
                    scale: self.model.originalImage.scale,
                    orientation: self.model.originalImage.imageOrientation  // ✅ Preserve orientation
                )
                self.objectWillChange.send()  // Ensure live updates
            }
        }
    }
}
