//
//  ImageRequest.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

public struct ImageCreateRequest: Encodable {
    
    public enum Size: String, Encodable {
        case s1024 = "1024x1024"
        case s512 = "512x512"
        case s256 = "256x256"
    }
    
    public enum OutputType: String, Encodable {
        case base64 = "b64_json"
        case url = "url"
    }
    
    public let prompt: String
    public let numberOfImages: Int
    public let size: Size
    public let outputType: OutputType
 
    enum CodingKeys: String, CodingKey {
        case prompt, size
        case numberOfImages = "n"
        case outputType = "response_format"
    }
    
    public init(prompt: String, numberOfImages: Int = 1, size: Size = .s1024, outputType: OutputType = .url) {
        self.prompt = prompt
        self.numberOfImages = numberOfImages
        self.size = size
        self.outputType = outputType
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(prompt, forKey: .prompt)
        try container.encode(numberOfImages, forKey: .numberOfImages)
        try container.encode(size, forKey: .size)
        try container.encode(outputType, forKey: .outputType)
    }
}
