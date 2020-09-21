//
//  ConteneView1.swift
//  VisionDemo
//
//  Created by Gaoshuo on 2020/9/20.
//

import SwiftUI

struct ContentView2: View {
    
    @State var imageSelected: Image? = nil
    @State var showGetImageView = false
    @State private var image: Image?
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    self.showGetImageView.toggle()
                }) {
                    Text("select photos")
                }
                
                Spacer().frame(height: 50)
                
                imageSelected?.resizable()
                    .frame(width: 300, height: 300)
                
                
            }
            if (showGetImageView) {
                GetImageView(shownBool: $showGetImageView, getImage: $imageSelected)
            }
        }
    }
    
//    var body: some View {
//        (image ?? Image (systemName: "photo")).resizable().scaledToFit().onAppear{
//            let uiImage=UIImage(named:"timg")!
//            NetworkManager.shared.removeImageBg(uiImage: uiImage){
//                (resultImage) in
//                if let resultImage = resultImage {
//                    self.image=Image(uiImage: resultImage)
//                }
//            }
//        }
//    }
    
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var showCoordinatorBool: Bool
    @Binding var coordinatorImage: Image?
    
    init(shownBool: Binding<Bool>, cordinatedImage: Binding<Image?>) {
        _showCoordinatorBool = shownBool
        _coordinatorImage = cordinatedImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let gotImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        coordinatorImage = Image(uiImage: gotImage)
        showCoordinatorBool = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        showCoordinatorBool = false
    }
}

struct GetImageView {
    
    @Binding var shownBool: Bool
    @Binding var getImage: Image?
    
    func makeCoordinator()-> Coordinator {
        return Coordinator(shownBool: $shownBool, cordinatedImage: $getImage)
    }
    
}


extension GetImageView: UIViewControllerRepresentable {
    func makeUIViewController(context:
        UIViewControllerRepresentableContext<GetImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context:UIViewControllerRepresentableContext<GetImageView>) {
    }
    
}






