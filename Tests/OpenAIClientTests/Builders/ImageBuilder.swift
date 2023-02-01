//
//  ImageBuilder.swift
//  
//
//  Created by Alberto Espinilla Garrido on 31/1/23.
//

import Foundation
@testable import OpenAIClient

final class ImageBuilder {
    private var created: Date = Date()
    private var data: [Image.Data] = [ImageDataBuilder().build()]
    
    func created(_ params: Date) -> Self {
        created = params
        return self
    }
    
    func data(_ params: [Image.Data]) -> Self {
        data = params
        return self
    }
    
    func build() -> Image {
        .init(created: created, data: data)
    }
}

final class ImageDataBuilder {
    private var url: String?
    private var base64: String?
    
    func url(_ params: String?) -> Self {
        url = params
        return self
    }
    
    func base64(_ params: String?) -> Self {
        base64 = params
        return self
    }
    
    func build() -> Image.Data {
        .init(url: url,
              base64: base64)
    }
}
