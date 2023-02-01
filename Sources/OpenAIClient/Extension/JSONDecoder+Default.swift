//
//  JSONDecoder+Default.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

extension JSONDecoder {
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
}
