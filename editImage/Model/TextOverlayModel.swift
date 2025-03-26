//
//  TextOverlayModel.swift
//  editImage
//
//  Created by Collins Roy on 19/03/25.
//


import UIKit

struct TextOverlayModel {
    var originalImage: UIImage
    var editedImage: UIImage?
    var text: String = ""
    var textPosition: CGPoint = CGPoint(x: 100, y: 100)
}
