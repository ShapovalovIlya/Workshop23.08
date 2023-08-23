//
//  UsersService.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 23.05.23.
//

import Foundation

protocol UserServiceable {
    func registerNewUser(email: String, username: String, firstName: String?, lastName: String?, profilePic: String?, password: String, rePassword: String, agreement: String) async -> Result<UserModel, HTTPError>
    func resetUserPass(email: String) async -> Result<AnyAnswerModel, HTTPError>
    func getUserProfile(token: String, imgFormat: String?, imgSize: String?) async -> Result<UserModel, HTTPError>
    func deleteUserProfile(token: String, password: String) async -> Result<AnyAnswerModel, HTTPError>
    func editUserProfile(token: String, firstName: String, lastName: String, profilePic: Data?) async -> Result<UserModel, HTTPError>
    func setUserPassword(token: String, newPassword: String, reNewPassword: String, currentPassword: String) async -> Result<AnyAnswerModel, HTTPError>
    func repeatedEmailRegistration(email: String) async -> Result<AnyAnswerModel, HTTPError>
}

class UserService: HTTPClient, UserServiceable {

    func registerNewUser(email: String, username: String, firstName: String?, lastName: String?, profilePic: String?, password: String, rePassword: String, agreement: String) async -> Result<UserModel, HTTPError> {
        return await sendRequest(endpoint: UserEndpoint.registerUser(email: email, username: username, firstName: firstName, lastName: lastName, profilePic: profilePic, password: password, rePassword: rePassword, agreement: agreement), responseModel: UserModel.self)
    }
    
    func resetUserPass(email: String) async -> Result<AnyAnswerModel, HTTPError> {
        return await sendRequest(endpoint: UserEndpoint.resetUserPassword(email: email), responseModel: AnyAnswerModel.self)
    }
    
    func getUserProfile(token: String, imgFormat: String?, imgSize: String?) async -> Result<UserModel, HTTPError> {
        return await sendRequest(endpoint: UserEndpoint.fetchUserProfile(token: token, imgFormat: imgFormat, imgSize: imgSize), responseModel: UserModel.self)
    }
    
    func deleteUserProfile(token: String, password: String) async -> Result<AnyAnswerModel, HTTPError> {
        return await sendRequest(endpoint: UserEndpoint.delUserProfile(token: token, password: password), responseModel: AnyAnswerModel.self)
    }
    
    func editUserProfile(token: String, firstName: String, lastName: String, profilePic: Data?) async -> Result<UserModel, HTTPError> {
        return await sendRequest(endpoint: UserEndpoint.editUserProfile(token: token, firstName: firstName, lastName: lastName, profilePic: profilePic), responseModel: UserModel.self)
    }
    
    func setUserPassword(token: String, newPassword: String, reNewPassword: String, currentPassword: String) async -> Result<AnyAnswerModel, HTTPError> {
        return await sendRequest(endpoint: UserEndpoint.setUserPassword(token: token, newPassword: newPassword, reNewPassword: reNewPassword, currentPassword: currentPassword), responseModel: AnyAnswerModel.self)
    }
    
    func repeatedEmailRegistration(email: String) async -> Result<AnyAnswerModel, HTTPError> {
        return await sendRequest(endpoint: UserEndpoint.repeatedEmailRegistration(email: email), responseModel: AnyAnswerModel.self)
    }
}
