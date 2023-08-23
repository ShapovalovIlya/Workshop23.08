//
//  InventoryModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 17.05.23.
//

import Foundation

// MARK: - InventoryModel
struct InventoryModel: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Inventory]?
}

// MARK: - Inventory
struct Inventory: Codable, Hashable {
    let id: Int?
    let amount: Int?
    let images: [ProfilePic]?
    let name, slug, description, unit: String?
    let seoTitle, seoDescription, seoKeywords, seoImgAlt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, description, images, amount, unit
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoImgAlt = "seo_img_alt"
    }
}
