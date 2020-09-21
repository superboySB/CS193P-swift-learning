//
//  ContentView.swift
//  SwiftUIVisionEmojiHunt
//
//  Created by Anupam Chugh on 01/06/20.
//  Copyright © 2020 iowncode. All rights reserved.
//

import SwiftUI

struct ContentView1: View {
    
    @State var timeRemaining = 10
    @State var timer = Timer.publish (every: 1, on: .main, in: .common).autoconnect()
    @State var showNext = false
    
    @State var emojiStatus = EmojiSearch.searching
    
    var emojiObjects = [EmojiModel(emoji: "📲", emojiName: "iPod")
                       ]
        
    @State var currentLevel = 0
    
    
    var body: some View {
        ZStack {
            
            CustomCameraRepresentable(emojiString: emojiObjects[currentLevel].emojiName, emojiFound: $emojiStatus)
            
            VStack(alignment: .leading, spacing: 16){
                Spacer()
                
                Text("\(timeRemaining)")
                    .font(.system(size:50, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                    
                
                emojiResultText()
            }
        }
        
    }
    
    func emojiResultText() -> Text {
       switch emojiStatus {
       case .found:
        return Text("\(emojiObjects[currentLevel].emoji) is FOUND")
            .font(.system(size:50, design: .rounded))
            .fontWeight(.bold)
       case .notFound:
            return Text("\(emojiObjects[currentLevel].emoji) NOT FOUND")
            .font(.system(size:50, design: .rounded))
            .foregroundColor(.red)
            .fontWeight(.bold)
       default:
            return Text(emojiObjects[currentLevel].emoji)
            .font(.system(size:50, design: .rounded))
            .fontWeight(.bold)
        
        }
    }
    
}

struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomCameraRepresentable: UIViewControllerRepresentable {
    
    var emojiString: String
    @Binding var emojiFound: EmojiSearch
    
    func makeUIViewController(context: Context) -> CameraVC {
        let controller = CameraVC(emoji: emojiString)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ cameraViewController: CameraVC, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(emojiFound: $emojiFound)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, EmojiFoundDelegate {
        
        @Binding var emojiFound: EmojiSearch
        
        init(emojiFound: Binding<EmojiSearch>) {
            _emojiFound = emojiFound
        }
        
        func emojiWasFound(result: Bool) {
            print("emojiWasFound \(result)")
            emojiFound = .found
        }
        
    }
}

protocol EmojiFoundDelegate{
    func emojiWasFound(result: Bool)
}

enum EmojiSearch{
    case found
    case notFound
    case searching
    case gameOver
}


struct EmojiModel{
    var emoji: String
    var emojiName: String
}
