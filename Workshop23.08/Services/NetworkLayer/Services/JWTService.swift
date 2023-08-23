//
//  JWTService.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 28.06.23.
//

import Foundation

protocol JWTServiceable {
    func loginUser(email: String, password: String) async -> Result<JWTTokenModel, HTTPError>
    func refreshUserToken(refresh: String) async -> Result<JWTTokenModel, HTTPError>
    func verifyUserToken(token: String) async -> Result<JWTTokenModel, HTTPError>
}

class JWTService: HTTPClient, JWTServiceable {

    func loginUser(email: String, password: String) async -> Result<JWTTokenModel, HTTPError> {
        return await sendRequest(endpoint: JWTEndpoint.jwtTokenCreate(email: email, password: password), responseModel: JWTTokenModel.self)
    }
    
    func refreshUserToken(refresh: String) async -> Result<JWTTokenModel, HTTPError> {
        return await sendRequest(endpoint: JWTEndpoint.jwtTokenRefresh(refreshToken: refresh), responseModel: JWTTokenModel.self)
    }
    
    func verifyUserToken(token: String) async -> Result<JWTTokenModel, HTTPError> {
        return await sendRequest(endpoint: JWTEndpoint.jwtTokenVerify(token: token), responseModel: JWTTokenModel.self)
    }
}
