//
//  UserAggregateModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 23.05.23.
//

import Foundation
//import KeychainSwift

struct KeychainSwift {
    func get(_ tokenType: String) -> String? { .init() }
    func set(_ tiken: String, forKey key: String) {}
    func delete(_ token: String) {}
}

@MainActor
class UserAggregateModel: ObservableObject {
    
    let keychain = KeychainSwift()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    let userService: UserService
    let jwtService: JWTService
    
    @Published var user: UserModel?
    
    var jwtRefresh: String = ""
    var jwtAccess: String = ""
    
    init(userService: UserService, jwtService: JWTService) {
        self.userService = userService
        self.jwtService = jwtService
        updateTokens()
    }
    
    func updateTokens() {
        self.jwtRefresh = self.getRefreshToken().0
        self.jwtAccess = self.getAccessToken().0
    }
    
    func registerNewUser(email: String, username: String, firstName: String? = nil, lastName: String? = nil, profilePic: String? = nil, password: String, rePassword: String, agreement: String) async throws {
        
        let queryResult = await userService.registerNewUser(email: email, username: username, firstName: firstName, lastName: lastName, profilePic: profilePic, password: password, rePassword: rePassword, agreement: agreement)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе registerNewUser ")
            user = result
            print("Новый пользователь зарегистрирован")
        case .failure(let error):
            print("Получили ошибку запроса registerNewUser:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func resetUserPassword(email: String) async throws {
        
        let queryResult = await userService.resetUserPass(email: email)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе resetUserPassword")
            print("Ответ от сервера", result.anyAnswer ?? "Не получили ответ от сервера на запрос resetUserPassword")
            print("Письмо для восстановления отправлено на почту")
        case .failure(let error):
            print("Получили ошибку запроса resetUserPassword:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func getUserProfile(token: String, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await userService.getUserProfile(token: token, imgFormat: imgFormat, imgSize: imgSize)
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе getUserProfile")
            user = result
            print(user?.email ?? "Не получили данных о почте пользователя")
            print("Профиль пользователя записан")
        case .failure(let error):
            print("Получили ошибку запроса getUserProfile:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func delUserProfile(token: String, password: String) async throws {
        
        let queryResult = await userService.deleteUserProfile(token: token, password: password)
        
        switch queryResult {
        case .success:
            print("Получили Result в запросе delUserProfile")
            print("Профиль пользователя удален")
        case .failure(let error):
            print("Получили ошибку запроса delUserProfile:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func editUserProfile(token: String, firstName: String, lastName: String, profilePic: Data? = nil) async throws {
        
        let queryResult = await userService.editUserProfile(token: token, firstName: firstName, lastName: lastName, profilePic: profilePic)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе editUserProfile")
            user = result
            print("Профиль пользователя изменен")
        case .failure(let error):
            print("Получили ошибку запроса editUserProfile:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func setUserPassword(token: String, newPassword: String, reNewPassword: String, currentPassword: String) async throws {
        
        let queryResult = await userService.setUserPassword(token: token, newPassword: newPassword, reNewPassword: reNewPassword, currentPassword: currentPassword)
        
        switch queryResult {
        case .success:
            print("Получили Result в запросе setUserPassword")
            print("Пароль изменен успешно")
        case .failure(let error):
            print("Получили ошибку запроса setUserPassword:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func jwtLoginUser(email: String, password: String) async throws {
        
        let queryResult = await jwtService.loginUser(email: email, password: password)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе jwtLoginUser")
            jwtAccess = result.access ?? "noJWTAccess"
            jwtRefresh = result.refresh ?? "noJWTRefresh"
            print("Получили токены аксесс и рефреш")
            saveAuthTokens(refreshToken: jwtRefresh, accessToken: jwtAccess)
            UserDefaults.standard.set(true, forKey: "isUserAuthenticated")
            print("accessToken =", getAccessToken().0, getAccessToken().1)
            print("refreshToken =", getRefreshToken().0, getRefreshToken().1)
            print("Надо ли обноалять =", shouldRefreshToken(currentDate: Date(), tokenExpirationDate: getAccessToken().1))
        case .failure(let error):
            print("Получили ошибку запроса jwtLoginUser:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func jwtRefreshUserToken(refresh: String) async throws {
        
        let queryResult = await jwtService.refreshUserToken(refresh: refresh)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе jwtRefreshUserToken")
            jwtAccess = result.access ?? "noJWTAccess"
        case .failure(let error):
            print("Получили ошибку запроса jwtRefreshUserToken:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func jwtVerifyUserToken(token: String) async throws {
        
        let queryResult = await jwtService.verifyUserToken(token: token)
        
        switch queryResult {
        case .success:
            print("Получили Result в запросе jwtVerifyUserToken")
            print("Токен активен и валиден")
        case .failure(let error):
            print("Получили ошибку запроса jwtVerifyUserToken:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func repeatedEmailRegistration(email: String) async throws {
        
        let queryResult = await userService.repeatedEmailRegistration(email: email)
        
        switch queryResult {
        case .success:
            print("Получили Result в запросе repeatedEmailRegistration")
            print("Письмо для повторной регистрации отправлено на почту")
        case .failure(let error):
            print("Получили ошибку запроса repeatedEmailRegistration:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    
}

// MARK: - extension UserAggregateModel
extension UserAggregateModel {
    
    func getAccessToken() -> (String, Date) {
        let token = keychain.get("accessToken") ?? "Аксесс токен не прочитался из кейчейна!!!"
        let expiresAt = dateFormatter.date(from: keychain.get("accessTokenExpire") ?? "") ?? Date.now
        
        //print("Получаем accessToken в гете: \(token), expiresAt: \(expiresAt)")
        
        return (token, expiresAt)
    }
    
    func getRefreshToken() -> (String, Date) {
        let token = keychain.get("refreshToken") ?? "Рефреш токен не прочитался из кейчейна!!!"
        let expiresAt = dateFormatter.date(from: keychain.get("refreshTokenExpire") ?? "") ?? Date.now
        
        //print("Получаем refreshToken в гете: \(token), expiresAt: \(expiresAt)")
        
        return (token, expiresAt)
    }
    
//    func isUserAuthenticated() async -> Bool {
//        let (accessToken, accessTokenExpiration) = getAccessToken()
//        let (refreshToken, refreshTokenExpiration) = getRefreshToken()
//
//        // Проверяем, есть ли у нас оба токена и действительны ли они.
//        if accessToken.isEmpty || refreshToken.isEmpty ||
//           shouldRefreshToken(currentDate: Date(), tokenExpirationDate: refreshTokenExpiration) {
//            return false
//        }
//
//        // Проверяем, истекло ли время действия токена доступа.
//        if shouldRefreshToken(currentDate: Date(), tokenExpirationDate: accessTokenExpiration) {
//            let queryResult = await jwtService.refreshUserToken(refresh: refreshToken)
//            switch queryResult {
//            case .success(let result):
//                // Обновление прошло успешно, сохраняем новый токен доступа.
//                let accessToken = result.access ?? "noAccess"
//                print("!!!!!! Новый аксесс токен =", accessToken)
//                print("!!!!!! Текущий рефреш токен =", refreshToken)
//                saveAuthTokens(refreshToken: refreshToken, accessToken: accessToken)
//                return true
//            case .failure(let error):
//                // Обновление не удалось, пользователь не аутентифицирован.
//                print("Ошибка обновления токена: \(error.localizedDescription)")
//                return false
//            }
//        }
//        // Токен доступа еще действителен, пользователь авторизован.
//        return true
//    }
    
    func isUserAuthenticated() async -> Bool {
        let (accessToken, _) = getAccessToken()
        let (refreshToken, refreshTokenExpiration) = getRefreshToken()

        // Проверяем, есть ли у нас оба токена и действительны ли они.
        if accessToken.isEmpty || refreshToken.isEmpty {
            return false
        }

        // Проверяем, истекло ли время действия токена обновления.
        if shouldRefreshToken(currentDate: Date(), tokenExpirationDate: refreshTokenExpiration) {
            // Если токен обновления истек, пользователь не аутентифицирован.
            return false
        }

        // Обновляем токен доступа, если это необходимо.
        guard await refreshTokenIfNeeded() else {
            return false
        }

        // Оба токена есть и они действительны, пользователь авторизован.
        return true
    }

    func refreshTokenIfNeeded() async -> Bool {
        let (_, accessTokenExpiration) = getAccessToken()
        
        // Проверяем, истекло ли время действия токена доступа.
        if shouldRefreshToken(currentDate: Date(), tokenExpirationDate: accessTokenExpiration) {
            let (refreshToken, _) = getRefreshToken()
            let queryResult = await jwtService.refreshUserToken(refresh: refreshToken)
            switch queryResult {
            case .success(let result):
                // Обновление прошло успешно, сохраняем новый токен доступа.
                let newAccessToken = result.access ?? "noAccess"
                saveAuthTokens(refreshToken: refreshToken, accessToken: newAccessToken)
                return true
            case .failure(_):
                // Обновление не удалось, пользователь не аутентифицирован.
                return false
            }
        }
        // Токен доступа еще действителен, обновление не требуется.
        return true
    }
    
    func decode(jwt: String) -> Date {
        let segments = jwt.components(separatedBy: ".")
        guard segments.count == 3 else { return Date.now}
        
        let payloadValue = segments[1]
        guard let decodedData = base64UrlDecode(payloadValue) else { return Date.now }
        
        do {
            let json = try JSONSerialization.jsonObject(with: decodedData, options: [])
            if let payload = json as? [String:Any], let exp = payload["exp"] as? TimeInterval {
                let expirationDate = Date(timeIntervalSince1970: exp)
                //print("Token expires at: \(expirationDate)")
                //print("Преобразованная дата =", convertToCurrentTimeZone(date: expirationDate))
                //return convertToCurrentTimeZone(date: expirationDate)
                return expirationDate
            }
        } catch {
            print("Failed to decode JWT: \(error)")
        }
        return Date.now
    }
    
    func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        while base64.count % 4 != 0 {
            base64.append("=")
        }
        
        return Data(base64Encoded: base64)
    }
    
    func saveAuthTokens(refreshToken: String, accessToken: String) {
        print("Вот что пришло в функцию сохранения токенов", "рефреш =", refreshToken, "аксесс =", accessToken)
        
        keychain.set(accessToken, forKey: "accessToken")
        keychain.set(dateFormatter.string(from: decode(jwt: accessToken)), forKey: "accessTokenExpire")
        
        print("Записалось в аксесс", getAccessToken())
        
        keychain.set(refreshToken, forKey: "refreshToken")
        keychain.set(dateFormatter.string(from: decode(jwt: refreshToken)), forKey: "refreshTokenExpire")
        
        print("Записалось в рефреш", getRefreshToken())
        
        updateTokens()
    }
    
    func haveAuthTokens() -> Bool {
        return !getAccessToken().0.isEmpty && !getRefreshToken().0.isEmpty
    }
    
    func dropTokens() {
        keychain.delete("accessToken")
        keychain.delete("accessTokenExpire")
        keychain.delete("refreshToken")
        keychain.delete("refreshTokenExpire")
    }
    
    func shouldRefreshToken(currentDate: Date, tokenExpirationDate: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: currentDate, to: tokenExpirationDate)
        //print("Даты которые сравниваем в токене", currentDate, tokenExpirationDate)
        if let minutes = components.minute, minutes <= 1 {
            return true
        } else {
            return false
        }
    }
}
