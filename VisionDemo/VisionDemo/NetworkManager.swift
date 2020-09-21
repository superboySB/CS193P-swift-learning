//
//  NetworkManager.swift
//  VisionDemo
//
//  Created by Gaoshuo on 2020/9/21.
//
import UIKit
import Alamofire

struct NetworkManager {
    static let shared = NetworkManager()
    
    func networkOperation(command: Int, uiImage: UIImage, complete: @escaping (UIImage?) -> Void) {
        let imageData = uiImage.jpegData(compressionQuality: 0.1)
        let base64Str = imageData!.base64EncodedString()
        let decoder = JSONDecoder()
        let parameters = UploadImageData (command: command, img: base64Str)
        
        AF.request("http://10.4.21.233:8015/test",
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default
            )
        .responseDecodable(of: ReturnImageData.self,queue: .main, decoder: decoder){ (response) in
            switch response.result{
                case .success(let receiveData):
                    let newImageData = Data(base64Encoded: receiveData.img)
                    if let newImage = UIImage(data: newImageData!){
                        complete(newImage)
                    }
                case .failure(_):
                    complete(nil)
            }

        }

        }
    }

