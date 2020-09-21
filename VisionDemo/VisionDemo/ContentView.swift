//
//  ContentView.swift
//  VisionDemo
//
//  Created by Gaoshuo on 2020/9/19.
//

import SwiftUI


struct ContentView: View {
    @State private var image: Image?

    var body: some View {
        NavigationView{
            CameraView()
        }



//        (image ?? Image (systemName: "photo")).resizable().scaledToFit().onAppear{
//            let uiImage=UIImage(named:"timg")!
//            NetworkManager.shared.networkOperation(command:1, uiImage: uiImage){
//                (resultImage) in
//                if let resultImage = resultImage {
//                    self.image=Image(uiImage: resultImage)
//                }
//            }
//        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}







