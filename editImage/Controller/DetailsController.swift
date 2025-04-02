import Foundation
import SwiftUI

class DetailsController: ObservableObject {
    @Published var brightness: Double = 0
    @Published var contrast: Double = 1
    @Published var saturation: Double = 1
    @Published var warmth: Double = 0
    @Published var shadows: Double = 0
    
    func applyFilters(to image: UIImage?) -> UIImage? {
        guard let image = image else { return nil }
        return ImageProcessor.shared.applyFilters(
            to: image,
            brightness: brightness,
            contrast: contrast,
            saturation: saturation,
            warmth: warmth,
            shadows: shadows
        )
    }
}
