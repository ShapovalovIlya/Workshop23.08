//
//  UserModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 23.05.23.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let id: Int?
    var email, username, firstName, lastName: String?
    var profilePic: ProfilePic?

    enum CodingKeys: String, CodingKey {
        case id, email, username
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
    }
}
