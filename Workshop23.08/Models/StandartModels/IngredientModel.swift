//
//  IngredientModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 17.05.23.
//

import Foundation

// MARK: - IngredientModel
struct IngredientModel: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Ingredient]?
}

// MARK: - Ingredient
struct Ingredient: Codable, Hashable, Identifiable {
    let id: Int?
    let name, slug: String?
    let unit: String?
    let amount: Int?
    let strength: Int?
    let categories: [Category]?
    let tastes: [Taste]?
    let description: String?
    let images: [ProfilePic]?
    let author: Author?
    var isInMyBar, isInShoppingList: Bool?
    let moderationStatus, seoTitle, seoDescription, seoKeywords: String?
    let seoImgAlt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, strength, tastes, categories, description, images, author, unit, amount
        case isInMyBar = "is_in_my_bar"
        case isInShoppingList = "is_in_shopping_list"
        case moderationStatus = "moderation_status"
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoImgAlt = "seo_img_alt"
    }
}
