//
//  CategoryModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 17.05.23.
//

import Foundation

// MARK: - CategoryModel
struct CategoryModel: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Category]?
}

// MARK: - Category
struct Category: Codable, Hashable {
    let id: Int?
    let name, slug, seoTitle, seoKeywords: String?
    let description, seoDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case seoTitle = "seo_title"
        case seoKeywords = "seo_keywords"
        case description
        case seoDescription = "seo_description"
    }
}
