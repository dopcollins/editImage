//
//  GalleryModel.swift
//  editImage
//
//  Created by Collins Roy on 19/02/25.
//
import Foundation
import SwiftUI
import UIKit

class GalleryModel: ObservableObject {
    @Published var selectedImage: UIImage?
    var isImageSelected: Bool {
        selectedImage != nil
    }
}

