import SwiftUI

struct ContentView: View {
    @StateObject private var model = ImageEditModel()
    @State private var isAddScreen = true
    
    var body: some View {
        NavigationView {
            VStack {
                if model.selectedImage != nil {
                    imageEditorScreen(selectedImage: $model.selectedImage)
                } else if isAddScreen {
                    Spacer()
                    addImageScreen()
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("VIVIDIFY")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    if !isAddScreen {
                        Button(action: {
                            isAddScreen = true
                            model.selectedImage = nil
                        }) {
                            Image(systemName: "chevron.backward")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .onChange(of: model.selectedImage) { _, newValue in
                isAddScreen = (newValue == nil)
            }
        }
    }

    private func addImageScreen() -> some View {
        VStack(spacing: 100) {
            Button(action: {
                model.isGalleryPickerPresented.toggle()
            }) {
                VStack(spacing: 2) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 170, height: 170)
                        .foregroundColor(.gray)
                        .padding()
                    
                    Text("Click here to select an image")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            .sheet(isPresented: $model.isGalleryPickerPresented) {
                GalleryPicker(selectedImage: $model.selectedImage)
            }
            .padding()
            .offset(x: 1, y: -50)
        }
        .padding()
    }

    private func imageEditorScreen(selectedImage: Binding<UIImage?>) -> some View {
        VStack {
            if let uiImage = selectedImage.wrappedValue {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                
                HStack(spacing: 20) {
                    NavigationLink(destination: ToolsView(selectedImage: selectedImage)) {
                        Text("Tools")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .padding()
                    }
                    
                    Button(action: {
                        saveImageToGallery(image: uiImage)
                    }) {
                        Text("Export")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .padding()
                    }
                }
                .padding(.vertical)
            }
        }
    }
    
    private func saveImageToGallery(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

#Preview {
    ContentView()
}
