import SwiftUI
import PencilKit

struct DrawOnImageView: View {
    @Binding var selectedImage: UIImage?
    @State private var canvasView = PKCanvasView()
    @State private var isToolPickerVisible = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack(alignment: .center) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height * 0.8)
                            .background(GeometryReader { imageGeo in
                                Color.clear
                                    .onAppear {
                                        // Match canvas size to the image's displayed size
                                        let displaySize = imageGeo.size
                                        canvasView.frame = CGRect(origin: .zero, size: displaySize)
                                        canvasView.bounds = CGRect(origin: .zero, size: displaySize)
                                    }
                            })
                    }
                    CanvasView(canvas: $canvasView, isToolPickerVisible: $isToolPickerVisible)
                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height * 0.8)
                        .background(Color.clear)
                }
                .background(Color.gray.opacity(0.1))
                .clipped()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                HStack(spacing: 15) {
                    toolButton(title: "Undo", systemImage: "arrow.uturn.left") {
                        canvasView.undoManager?.undo()
                    }
                    .disabled(!(canvasView.undoManager?.canUndo ?? false))
                    
                    toolButton(title: "Redo", systemImage: "arrow.uturn.right") {
                        canvasView.undoManager?.redo()
                    }
                    .disabled(!(canvasView.undoManager?.canRedo ?? false))
                    
                    toolButton(title: "Clear", systemImage: "trash") {
                        canvasView.drawing = PKDrawing()
                    }
                    
                    toolButton(title: isToolPickerVisible ? "Hide" : "Tools", systemImage: isToolPickerVisible ? "eye.slash" : "eye") {
                        isToolPickerVisible.toggle()
                    }
                    
                    Spacer()
                    
                    toolButton(title: "Cancel", systemImage: "xmark") {
                        dismiss()
                    }
                    
                    toolButton(title: "Save", systemImage: "checkmark") {
                        saveDrawingToImage(geometry: geometry)
                        dismiss()
                    }
                }
                .padding()
                .frame(maxWidth: geometry.size.width)
                .background(Color(.systemBackground))
            }
        }
        .navigationTitle("Draw on Image")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveDrawingToImage(geometry: GeometryProxy) {
        guard let originalImage = selectedImage else { return }
        
        let imageSize = originalImage.size
        let displaySize = canvasView.bounds.size // Use the canvas's bounds (set to displayed size)
        _ = imageSize.width / displaySize.width
        _ = imageSize.height / displaySize.height
        
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        let newImage = renderer.image { context in
            // Draw the original image
            originalImage.draw(in: CGRect(origin: .zero, size: imageSize))
            
            // Get the drawing and scale it to the original image size
            let drawingImage = canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
            drawingImage.draw(in: CGRect(
                x: 0,
                y: 0,
                width: imageSize.width,
                height: imageSize.height
            ))
        }
        
        selectedImage = newImage
        canvasView.drawing = PKDrawing()
    }
    
    private func toolButton(title: String, systemImage: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack {
                Image(systemName: systemImage)
                    .font(.system(size: 20))
                Text(title)
                    .font(.caption)
            }
            .frame(width: 60, height: 60)
            .background(Color.gray.opacity(0.2))
            .foregroundColor(.primary)
            .cornerRadius(8)
        }
    }
}

struct CanvasView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var isToolPickerVisible: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.tool = PKInkingTool(.pen, color: .black, width: 5)
        context.coordinator.setupToolPicker(for: canvas)
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        context.coordinator.updateToolPickerVisibility(isVisible: isToolPickerVisible, for: uiView)
    }
    
    class Coordinator {
        private let parent: CanvasView
        private let toolPicker: PKToolPicker
        
        init(_ parent: CanvasView) {
            self.parent = parent
            self.toolPicker = PKToolPicker()
        }
        
        func setupToolPicker(for canvas: PKCanvasView) {
            toolPicker.addObserver(canvas)
            toolPicker.setVisible(parent.isToolPickerVisible, forFirstResponder: canvas)
            if parent.isToolPickerVisible {
                canvas.becomeFirstResponder()
            }
        }
        
        func updateToolPickerVisibility(isVisible: Bool, for canvas: PKCanvasView) {
            toolPicker.setVisible(isVisible, forFirstResponder: canvas)
            if isVisible {
                canvas.becomeFirstResponder()
            }
        }
    }
}
