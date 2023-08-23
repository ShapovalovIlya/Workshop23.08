//
//  ProfilePicModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 6.06.23.
//

import Foundation

// MARK: - ProfilePic
struct ProfilePic: Codable, Hashable {
    let id: Int?
    let imageName: String?
    let bigImage, mediumImage, smallImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case imageName = "image_name"
        case bigImage = "big_image"
        case mediumImage = "medium_image"
        case smallImage = "small_image"
    }
}
