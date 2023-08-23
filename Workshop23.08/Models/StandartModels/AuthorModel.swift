//
//  Author.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 17.05.23.
//

import Foundation

// MARK: - Author
struct Author: Codable, Hashable {
    let id: Int?
    let username, firstName, lastName: String?
    let profilePic: ProfilePic?

    enum CodingKeys: String, CodingKey {
        case id, username
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
    }
}
