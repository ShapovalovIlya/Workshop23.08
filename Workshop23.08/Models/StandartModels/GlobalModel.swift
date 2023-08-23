//
//  GlobalModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 22.07.23.
//

import Foundation

// MARK: - GlobalModel
struct GlobalModel: Codable {
    let count, cocktailsCount, ingredientsCount: Int?
    let next, previous: String?
    let results: [Global]?

    enum CodingKeys: String, CodingKey {
        case count
        case cocktailsCount = "cocktails_count"
        case ingredientsCount = "ingredients_count"
        case next, previous, results
    }
}

// MARK: - Result
struct Global: Codable {
    let id: Int?
    let name, slug, description: String?
    let strengths, tastes: [Category]?
    let complexities: [Complexity]?
    let formats: [Format]?
    let images: [ProfilePic]?
    let author: Author?
    let ingredients: [Ingredient]?
    let inventory: [Inventory]?
    let steps: [Step]?
    let isFavorited: Bool?
    let seoTitle, seoDescription, seoKeywords: String?
    let seoImgAlt, moderationStatus: String?
    let avgRating, amountVotes: Int?
    let object: String?
    let strength: Int?
    let categories: [Category]?
    let isInMyBar, isInShoppingList: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, description, strengths, tastes, complexities, formats, images, author, ingredients, inventory, steps
        case isFavorited = "is_favorited"
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoImgAlt = "seo_img_alt"
        case moderationStatus = "moderation_status"
        case avgRating = "avg_rating"
        case amountVotes = "amount_votes"
        case object, strength, categories
        case isInMyBar = "is_in_my_bar"
        case isInShoppingList = "is_in_shopping_list"
    }
}
