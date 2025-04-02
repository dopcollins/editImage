import Foundation
import UIKit
import TOCropViewController

class CropController: NSObject, ObservableObject, TOCropViewControllerDelegate {
    @Published var croppedImage: UIImage?

    func createCropViewController(for image: UIImage) -> TOCropViewController {
        let cropViewController = TOCropViewController(image: image)
        cropViewController.delegate = self
        return cropViewController
    }

    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        DispatchQueue.main.async {
            self.croppedImage = image
            cropViewController.dismiss(animated: true)
        }
    }

    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true)
    }
    
}
