import Foundation
import SwiftUI

class ToolsController: ObservableObject {
    @Published var selectedTool: ToolOption?
    
    enum ToolOption {
        case crop, details, curve, editing
    }
}
