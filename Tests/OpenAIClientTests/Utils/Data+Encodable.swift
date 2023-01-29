//
//  Data+Encodable.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

extension Encodable {
    func data(encoder: JSONEncoder = .init()) -> Data? {
        try? encoder.encode(self)
    }
}
