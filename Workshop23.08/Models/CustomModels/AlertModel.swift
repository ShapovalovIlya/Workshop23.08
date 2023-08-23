//
//  AlertModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 14.07.23.
//

import Foundation

struct AlertItem: Identifiable {
    let id = UUID()
    let message: String
    let alertType: AlertType
}

enum AlertType {
    case success, failure
}
