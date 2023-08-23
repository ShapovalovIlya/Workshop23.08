//
//  FormatModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 17.05.23.
//

import Foundation

// MARK: - FormatModel
struct FormatModel: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Format]?
}

// MARK: - Format
struct Format: Codable, Hashable {
    let id: Int?
    let name, slug, seoTitle, seoKeywords: String?
    let description, seoDescription: String?
    let images: [ProfilePic]?
    let seoImgAlt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case seoTitle = "seo_title"
        case seoKeywords = "seo_keywords"
        case description
        case seoDescription = "seo_description"
        case images
        case seoImgAlt = "seo_img_alt"
    }
}
