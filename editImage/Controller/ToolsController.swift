//
//  ToolsController.swift
//  editImage
//
//  Created by Collins Roy on 22/02/25.
import Foundation
import SwiftUI

class ToolsController: ObservableObject {
    @Published var selectedTool: ToolOption?
    
    enum ToolOption {
        case crop, details, curve, editing
    }
}
