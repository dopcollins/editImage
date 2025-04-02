import Foundation
import SwiftUI
import UIKit

class GalleryModel: ObservableObject {
    @Published var selectedImage: UIImage?
    var isImageSelected: Bool {
        selectedImage != nil
    }
}

