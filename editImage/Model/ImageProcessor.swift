import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

class ImageProcessor {
    static let shared = ImageProcessor()
    private let context = CIContext()

    func applyFilters(to image: UIImage, brightness: Double, contrast: Double, saturation: Double, warmth: Double, shadows: Double) -> UIImage {
        let ciImage = CIImage(image: image)
        
        let filter = CIFilter.colorControls()
        filter.inputImage = ciImage
        filter.brightness = Float(brightness)
        filter.contrast = Float(contrast)
        filter.saturation = Float(saturation)
        
        let temperatureFilter = CIFilter.temperatureAndTint()
        temperatureFilter.inputImage = filter.outputImage
        temperatureFilter.neutral = CIVector(x: 6500 + CGFloat(warmth * 1000), y: 0)
        
        let shadowFilter = CIFilter.highlightShadowAdjust()
        shadowFilter.inputImage = temperatureFilter.outputImage
        shadowFilter.shadowAmount = Float(shadows)
        
        if let outputImage = shadowFilter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation) // ✅ Preserve orientation
        }
        return image
    }
}

