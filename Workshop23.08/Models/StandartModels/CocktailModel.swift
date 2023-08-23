//
//  CocktailModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 13.05.23.
//

import Foundation

// MARK: - CocktailModel
struct CocktailModel: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Cocktail]?
}

// MARK: - Cocktail
struct Cocktail: Codable, Hashable, Identifiable {
    let id: Int?
    let name, slug: String?
    let images: [ProfilePic]?
    let description: String?
    let complexities: [Complexity]?
    let strengths: [Strength]?
    let tastes: [Taste]?
    let formats: [Format]?
    let author: Author?
    var isFavorited: Bool
    let ingredients: [Ingredient]?
    let inventory: [Inventory]?
    let steps: [Step]?
    let moderationStatus, seoTitle, seoDescription, seoKeywords: String?
    let seoImgAlt: String?
    let avgRating: Double?
    let amountVotes: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, images, description, strengths, tastes, complexities, formats, author
        case isFavorited = "is_favorited"
        case ingredients, inventory, steps
        case moderationStatus = "moderation_status"
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoImgAlt = "seo_img_alt"
        case avgRating = "avg_rating"
        case amountVotes = "amount_votes"
    }
    
        static let mockup = Cocktail(
            id: nil,
            name: "Джин тоник",
            slug: nil,
            images: nil,
            description: "Это бессмертный микс джина и тоника. Это бессмертный микс джина и тоника",
            complexities: nil, strengths: nil,
            tastes: nil,
            formats: nil,
            author: nil,
            isFavorited: true,
            ingredients: nil, inventory: nil,
            steps: nil,
            moderationStatus: nil,
            seoTitle: nil,
            seoDescription: nil,
            seoKeywords: nil,
            seoImgAlt: nil,
            avgRating: 5.7,
            amountVotes: nil
        )
}

