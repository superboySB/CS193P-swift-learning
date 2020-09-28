//
//  ContentView1.swift
//  VisionDemo
//
//  Created by Gaoshuo on 2020/9/28.
//

import SwiftUI

struct LivenessCheckViewControllerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LivenessCheckViewController {
        UIStoryboard(name:"Main", bundle: nil).instantiateViewController(identifier: "LivenessCheckViewController") as LivenessCheckViewController
    }
    
    func updateUIViewController(_ uiViewController: LivenessCheckViewController, context: Context) {
    }
    
    typealias UIViewControllerType = LivenessCheckViewController
}

struct LivenessCheckViewControllerView_Previews: PreviewProvider {
    static var previews: some View {
        LivenessCheckViewControllerView()
    }
}
