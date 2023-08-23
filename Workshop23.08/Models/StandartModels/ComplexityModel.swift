//
//  ComplexityModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 17.05.23.
//

import Foundation

// MARK: - ComplexityModel
struct ComplexityModel: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Complexity]?
}

// MARK: - Complexity
struct Complexity: Codable, Hashable {
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
