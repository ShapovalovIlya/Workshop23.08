//
//  StepModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 17.05.23.
//

import Foundation

// MARK: - Step
struct Step: Codable, Hashable {
    let id: Int?
    let name, description: String?
}
