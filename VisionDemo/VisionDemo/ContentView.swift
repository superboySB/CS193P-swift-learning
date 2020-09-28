//
//  ConteneView1.swift
//  VisionDemo
//
//  Created by Gaoshuo on 2020/9/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var imageSelected: Image? = nil
    @State var showGetImageView = false
    @State var modeSelected: Int = 1
    
    let modes = [
        "人脸检测",
        "关键点检测",
        "活体检测",
        "年龄检测",
        "性别检测",
        "表情检测",
        "种族检测",
    ]
    
    var body: some View {
        VStack{
            if (modeSelected != 3) {
                if (showGetImageView){
                    GetImageView(shownBool: $showGetImageView, getImage: $imageSelected, modeNumber: $modeSelected)
                }
                else{
                    if imageSelected == nil {
                        GetImageView(shownBool: $showGetImageView, getImage: $imageSelected, modeNumber: $modeSelected)
                    }
                    else{
                        CameraView().overlay(
                            imageSelected!
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 333, alignment: .center),
                            alignment: .topTrailing
                            )

                    }
                }
            }
            else{
                CameraView()
            }
            
            ScrollView(.horizontal){
                let rows = [GridItem()]
                LazyHGrid(rows: rows){
                    ForEach(modes.indices) { (index) in
                        Button(action: {
                            modeSelected = index+1
                            showGetImageView = true
                            
                        }){
                            VStack{
                                Image(modes[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 170)
                                    .clipped()
                                Text(modes[index])
                                Spacer(minLength: 10)
                            }
                        }
                        .overlay(
                            Image(systemName: "\(index+1).circle.fill")
                                .font(.largeTitle)
                            , alignment: .topLeading
                        )
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            
            HStack(spacing:8){
                Text("版权所有 . 北京理工大学计算机学院").font(.system(size:10))
                Image("BIT").resizable().frame(width: 30, height: 30)
            }

        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var showCoordinatorBool: Bool
    @Binding var coordinatorImage: Image?
    @Binding var modeCoordinatorNumber: Int
    
    init(shownBool: Binding<Bool>, cordinatedImage: Binding<Image?>, cordinatedMode: Binding<Int>) {
        _showCoordinatorBool = shownBool
        _coordinatorImage = cordinatedImage
        _modeCoordinatorNumber = cordinatedMode
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let gotImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        
        NetworkManager.shared.networkOperation(command: modeCoordinatorNumber, uiImage: gotImage){
            (resultImage) in
            if let resultImage = resultImage {
                self.coordinatorImage=Image(uiImage: resultImage)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            self.showCoordinatorBool = false
        }

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        showCoordinatorBool = false
    }
}

struct GetImageView {
    
    @Binding var shownBool: Bool
    @Binding var getImage: Image?
    @Binding var modeNumber: Int
    
    func makeCoordinator()-> Coordinator {
        return Coordinator(shownBool: $shownBool, cordinatedImage: $getImage, cordinatedMode: $modeNumber)
    }
    
}



extension GetImageView: UIViewControllerRepresentable {
    func makeUIViewController(context:
        UIViewControllerRepresentableContext<GetImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.cameraDevice = .front

        
//        picker.showsCameraControls = false

        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context:UIViewControllerRepresentableContext<GetImageView>) {
    }
    
}


//    (image ?? Image (systemName: "photo")).resizable().scaledToFit().onAppear{
//                let uiImage=UIImage(named:"timg")!
//                NetworkManager.shared.networkOperation(command:5, uiImage: uiImage){
//                    (resultImage) in
//                    if let resultImage = resultImage {
//                        self.image=Image(uiImage: resultImage)
//                    }
//                }
//            }





