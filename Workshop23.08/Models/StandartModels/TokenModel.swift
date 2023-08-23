//
//  TokenModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 26.05.23.
//

import Foundation

// MARK: - TokenModel
struct TokenModel: Codable, Hashable {
    let authToken: String?

    enum CodingKeys: String, CodingKey {
        case authToken = "auth_token"
    }
}
