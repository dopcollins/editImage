//
//  File.swift
//  editImage
//
//  Created by Collins Roy on 19/03/25.
//

import UIKit

struct TuneImageModel {
    var originalImage: UIImage
    var adjustedImage: UIImage?
    var smoothness: Double = 0.0  // 0 = No blur, 2 = Max blur
    var sharpness: Double = 1.0
}
