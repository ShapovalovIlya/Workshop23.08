//
//  CocktailRecomendationModel.swift
//  Partyshaker
//
//  Created by Alexey Opexov on 10.08.2023.
//

import Foundation

struct CocktailRecommendationModel: Codable {
    let count: Int?
    let next, previous: String?
    let results: [CocktailRecomendation]?
}

struct CocktailRecomendation: Codable, Identifiable {
    let id = UUID()
    var cocktail: Cocktail
    let needToBuy: [NeedToBuy]?
    let percent: Double?
    
    enum CodingKeys: String, CodingKey {
        case cocktail
        case needToBuy = "need_to_buy"
        case percent
    }
}

struct NeedToBuy: Codable {
    let id: Int
    let name: String?
    let slug: String?
}
