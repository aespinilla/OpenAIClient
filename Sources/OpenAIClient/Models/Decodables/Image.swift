//
//  Image.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

public struct Image: Decodable {
    public struct Data: Decodable {
        let url: String?
        let base64: String?
        
        enum CodingKeys: String, CodingKey {
            case url
            case base64 = "b64_json"
        }
    }
    
    public let created: Date
    public let data: [Data]
}
