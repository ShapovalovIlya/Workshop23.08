//
//  UsersEndpoint.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 23.05.23.
//

import Foundation

enum UserEndpoint {
    case registerUser(email: String, username: String, firstName: String?, lastName: String?, profilePic: String?, password: String, rePassword: String, agreement: String)
    case resetUserPassword(email: String)
    case fetchUserProfile(token: String, imgFormat: String?, imgSize: String?)
    case delUserProfile(token: String, password: String)
    case editUserProfile(token: String, firstName: String, lastName: String, profilePic: Data?)
    case setUserPassword(token: String, newPassword: String, reNewPassword: String, currentPassword: String)
    case repeatedEmailRegistration(email: String)
}

extension UserEndpoint: Endpoint {
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
        case .registerUser:
            return "/api/users/"
        case .resetUserPassword:
            return "/api/users/reset_password/"
        case .fetchUserProfile:
            return "/api/users/me/"
        case .delUserProfile:
            return "/api/users/me/"
        case .editUserProfile:
            return "/api/users/me/"
        case .setUserPassword:
            return "/api/users/set_password/"
        case .repeatedEmailRegistration:
            return "/api/users/resend_activation/"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .fetchUserProfile(token: _, imgFormat: let imgFormat, imgSize: let imgSize):
            var queryItems = [URLQueryItem]()
            if let imgFormat = imgFormat {
                queryItems.append(URLQueryItem(name: "img_format", value: imgFormat))
            }
            if let imgSize = imgSize {
                queryItems.append(URLQueryItem(name: "img_size", value: imgSize))
            }
            return queryItems
        default:
            return []
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .registerUser:
            return .post
        case .resetUserPassword:
            return .post
        case .fetchUserProfile:
            return .get
        case .delUserProfile:
            return .delete
        case .editUserProfile:
            return .patch
        case .setUserPassword:
            return .post
        case .repeatedEmailRegistration:
            return .post
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .registerUser:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        case .resetUserPassword:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        case .fetchUserProfile(token: let token, imgFormat: _, imgSize: _):
            return [
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
        case .delUserProfile(token: let token, password: _) :
            return [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .editUserProfile(token: let token, firstName: _, lastName: _, profilePic: _):
            return [
                "Content-Type": "multipart/form-data",
                "Authorization": "Bearer \(token)"
            ]
        case .setUserPassword(token: let token, newPassword: _, reNewPassword: _, currentPassword: _):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
        case .repeatedEmailRegistration:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .registerUser(let email, let username, let firstName, let lastName, let profilePic, let password, let rePassword, let agreement):
            var bodyParams: [String: Any] = [
                "email": email as Any,
                "username": username as Any,
                "password": password as Any,
                "re_password": rePassword as Any,
                "agreement": agreement as Any
            ]
            if let firstName = firstName {
                bodyParams["first_name"] = firstName
            }
            if let lastName = lastName {
                bodyParams["last_name"] = lastName
            }
            if let profilePic = profilePic {
                bodyParams["profile_pic"] = profilePic
            }
            return bodyParams
        case .resetUserPassword(email: let email):
            let bodyParams: [String: Any] = [
                "email": email as Any
            ]
            return bodyParams
        case .fetchUserProfile:
            return nil
        case .delUserProfile(token: _, password: let password):
            let bodyParams: [String: Any] = [
                "current_password": password as Any
            ]
            return bodyParams
        case .editUserProfile:
            return nil
        case .setUserPassword(token: _, newPassword: let newPassword, reNewPassword: let reNewPassword, currentPassword: let currentPassword):
            let bodyParams: [String: Any] = [
                "new_password": newPassword as Any,
                "re_new_password": reNewPassword as Any,
                "current_password": currentPassword as Any
            ]
            return bodyParams
        case .repeatedEmailRegistration(email: let email):
            let bodyParams: [String: Any] = [
                "email": email as Any
            ]
            return bodyParams
        }
    }
    
    var multipartFormData: [MultipartFormData]? {
        switch self {
        case .editUserProfile(token: _, firstName: let firstName, lastName: let lastName, profilePic: let profilePicData):
            var formData: [MultipartFormData] = [
                MultipartFormData(data: firstName.data(using: .utf8)!, name: "first_name"),
                MultipartFormData(data: lastName.data(using: .utf8)!, name: "last_name")
            ]
            if let profilePicData = profilePicData {
                formData.append(MultipartFormData(data: profilePicData, name: "profile_pic", fileName: "profile.jpeg", mimeType: "image/jpeg"))
            }
            return formData
        default:
            return nil
        }
    }
}
