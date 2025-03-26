//
//  ImageModel.swift
//  editImage
//
//  Created by Collins Roy on 19/02/25.
//
import Foundation
import SwiftUI

class ImageEditModel: ObservableObject {
    @Published var selectedImage: UIImage? = nil
    @Published var isGalleryPickerPresented = false
    
    var isImageSelected: Bool {
        return selectedImage != nil
    }
}

