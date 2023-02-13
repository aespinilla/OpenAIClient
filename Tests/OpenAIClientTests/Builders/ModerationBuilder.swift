//
//  ModerationBuilder.swift
//  
//
//  Created by Alberto Espinilla Garrido on 13/2/23.
//

import Foundation
@testable import OpenAIClient

final class ModerationBuilder {
    private var id: String = ""
    private var model: String = ""
    private var results: [Moderation.Result] = [ModerationResultBuilder().build()]
    
    func id(_ params: String) -> Self {
        id = params
        return self
    }
    
    func model(_ params: String) -> Self {
        model = params
        return self
    }
    
    func results(_ params: [Moderation.Result]) -> Self {
        results = params
        return self
    }
    
    func build() -> Moderation {
        .init(id: id, model: model, results: results)
    }
}

final class ModerationResultBuilder {
    private var flagged: Bool = false
    private var categories: Moderation.Result.Categories = ModerationResultCategoriesBuilder().build()
    private var categoryScores: Moderation.Result.CategoryScore = ModerationResultCategoryScoreBuilder().build()
    
    func flagged(_ params: Bool) -> Self {
        flagged = params
        return self
    }
    
    func categories(_ params: Moderation.Result.Categories) -> Self {
        categories = params
        return self
    }
    
    func categoryScores(_ params: Moderation.Result.CategoryScore) -> Self {
        categoryScores = params
        return self
    }
    
    func build() -> Moderation.Result {
        .init(flagged: flagged, categories: categories, categoryScores: categoryScores)
    }
}

final class ModerationResultCategoriesBuilder {
    private var sexual: Bool = false
    private var hate: Bool = false
    private var violence: Bool = false
    private var selfHarm: Bool = false
    private var sexualMinors: Bool = false
    private var hateThreatening: Bool = false
    private var violenceGraphic: Bool  = false
    
    func sexual(_ params: Bool) -> Self {
        sexual = params
        return self
    }
    
    func hate(_ params: Bool) -> Self {
        hate = params
        return self
    }
    
    func violence(_ params: Bool) -> Self {
        violence = params
        return self
    }
    
    func selfHarm(_ params: Bool) -> Self {
        selfHarm = params
        return self
    }
    
    func sexualMinors(_ params: Bool) -> Self {
        sexualMinors = params
        return self
    }
    
    func hateThreatening(_ params: Bool) -> Self {
        hateThreatening = params
        return self
    }
    
    func violenceGraphic(_ params: Bool) -> Self {
        violenceGraphic = params
        return self
    }
    
    func build() -> Moderation.Result.Categories {
        .init(sexual: sexual,
              hate: hate,
              violence: violence,
              selfHarm: selfHarm,
              sexualMinors: sexualMinors,
              hateThreatening: hateThreatening,
              violenceGraphic: violenceGraphic)
    }
}

final class ModerationResultCategoryScoreBuilder {
    private var sexual: Double = 0.0
    private var hate: Double = 0.0
    private var violence: Double = 0.0
    private var selfHarm: Double = 0.0
    private var sexualMinors: Double = 0.0
    private var hateThreatening: Double = 0.0
    private var violenceGraphic: Double = 0.0
    
    func sexual(_ params: Double) -> Self {
        sexual = params
        return self
    }
    
    func hate(_ params: Double) -> Self {
        hate = params
        return self
    }
    
    func violence(_ params: Double) -> Self {
        violence = params
        return self
    }
    
    func selfHarm(_ params: Double) -> Self {
        selfHarm = params
        return self
    }
    
    func sexualMinors(_ params: Double) -> Self {
        sexualMinors = params
        return self
    }
    
    func hateThreatening(_ params: Double) -> Self {
        hateThreatening = params
        return self
    }
    
    func violenceGraphic(_ params: Double) -> Self {
        violenceGraphic = params
        return self
    }
    
    func build() -> Moderation.Result.CategoryScore {
        .init(sexual: sexual,
              hate: hate,
              violence: violence,
              selfHarm: selfHarm,
              sexualMinors: sexualMinors,
              hateThreatening: hateThreatening,
              violenceGraphic: violenceGraphic)
    }
}
