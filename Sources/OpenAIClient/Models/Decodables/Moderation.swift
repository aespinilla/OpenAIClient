//
//  Moderation.swift
//  
//
//  Created by Alberto Espinilla Garrido on 13/2/23.
//

import Foundation

public struct Moderation: Decodable, Equatable {
    public struct Result: Decodable, Equatable {
        public struct Categories: Decodable, Equatable {
            public let sexual: Bool
            public let hate: Bool
            public let violence: Bool
            public let selfHarm: Bool
            public let sexualMinors: Bool
            public let hateThreatening: Bool
            public let violenceGraphic: Bool
            
            public enum CodingKeys: String, CodingKey {
                case sexual, hate, violence
                case selfHarm = "self-harm"
                case sexualMinors = "sexual/minors"
                case hateThreatening = "hate/threatening"
                case violenceGraphic = "violence/graphic"
            }
        }
        
        public struct CategoryScore: Decodable, Equatable {
            public let sexual: Double
            public let hate: Double
            public let violence: Double
            public let selfHarm: Double
            public let sexualMinors: Double
            public let hateThreatening: Double
            public let violenceGraphic: Double
            
            public enum CodingKeys: String, CodingKey {
                case sexual, hate, violence
                case selfHarm = "self-harm"
                case sexualMinors = "sexual/minors"
                case hateThreatening = "hate/threatening"
                case violenceGraphic = "violence/graphic"
            }
        }
        
        let flagged: Bool
        let categories: Categories
        let categoryScores: CategoryScore
        
        public enum CodingKeys: String, CodingKey {
            case flagged, categories
            case categoryScores = "category_scores"
        }
    }
    
    public let id: String
    public let model: String
    public let results: [Result]
}
