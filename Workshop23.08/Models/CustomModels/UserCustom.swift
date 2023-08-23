//
//  UserCustom.swift
//  PartyShacker
//
//  Created by Alexey Opexov on 16.05.2023.
//

import SwiftUI

struct UserCustom {
    var nickname: String
    var name: String
    var surname: String
    var email: String
    var password: String
    var photo: String?
    
    static let mockup = UserCustom(
        nickname: "Usualbarman123",
        name: "Ольга",
        surname: "Воробьева",
        email: "user@email.com",
        password: "qwerty",
        photo: "user"
    )
}
