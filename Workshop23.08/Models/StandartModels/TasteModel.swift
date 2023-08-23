//
//  TasteModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 22.05.23.
//

import Foundation

// MARK: - TasteModel
struct TasteModel: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Taste]?
}

// MARK: - Taste
struct Taste: Codable, Hashable {
    let id: Int?
    let name, slug, seoTitle, seoKeywords: String?
    let seoDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case seoTitle = "seo_title"
        case seoKeywords = "seo_keywords"
        case seoDescription = "seo_description"
    }
}
