import Foundation
import SwiftUI

class ImageEditModel: ObservableObject {
    @Published var selectedImage: UIImage? = nil
    @Published var isGalleryPickerPresented = false
    
    var isImageSelected: Bool {
        return selectedImage != nil
    }
}

