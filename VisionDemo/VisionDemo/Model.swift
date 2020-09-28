//
//  Model.swift
//  VisionDemo
//
//  Created by Gaoshuo on 2020/9/21.
//


struct UploadImageData: Encodable{
    let command: Int
    let img: String
}

struct UploadImageDataWithToken: Encodable{
    let token: String
    let command: Int
    let img: String
}


struct ReturnImageData: Decodable {
    let command: Int
    let img: String
}
