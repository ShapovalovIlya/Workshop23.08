//
//  JWTTokenModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 27.06.23.
//

import Foundation

// MARK: - JWTTokenModel
struct JWTTokenModel: Codable {
    let refresh, access: String?
}
