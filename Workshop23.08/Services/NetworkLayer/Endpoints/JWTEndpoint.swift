//
//  JWTEndpoint.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 27.06.23.
//

import Foundation

enum JWTEndpoint {
    case jwtTokenCreate(email: String, password: String)
    case jwtTokenRefresh(refreshToken: String)
    case jwtTokenVerify(token: String)
}

extension JWTEndpoint: Endpoint {
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        default:
            return Constants.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .jwtTokenCreate:
            return "/api/auth/jwt/create/"
        case .jwtTokenRefresh:
            return "/api/auth/jwt/refresh/"
        case .jwtTokenVerify:
            return "/api/auth/jwt/verify/"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        default:
            return []
        }
    }
    
    var method: RequestMethod {
        switch self {
        default:
            return .post
        }
    }
    
    var header: [String : String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .jwtTokenCreate(email: let email, password: let password):
            let bodyParams: [String: Any] = [
                "password": password as Any,
                "email": email as Any
            ]
            return bodyParams
        case .jwtTokenRefresh(refreshToken: let refreshToken):
            let bodyParams: [String: Any] = [
                "refresh": refreshToken as Any
            ]
            return bodyParams
        case .jwtTokenVerify(token: let token):
            let bodyParams: [String: Any] = [
                "token": token as Any
            ]
            return bodyParams
        }
    }
    
    var multipartFormData: [MultipartFormData]? {
        return nil
    }
}
