//
//  RequestError.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 13.05.23.
//
/*
 `HTTPError` - это перечисление, определённое в Swift, предназначенное для представления различных типов ошибок, которые могут возникнуть при выполнении HTTP-запроса. Оно реализует протокол `LocalizedError`, что позволяет предоставить локализованное описание ошибки.
 
 Каждый случай в перечислении представляет собой различные типы ошибок, такие как `badRequest`, `unauthorized`, `notFound`, `methodNotAllowed`, `decodingError` и другие, которые могут возникнуть в процессе HTTP-запроса. Каждый тип ошибки имеет связанное значение (ассоциированный тип) `String?`, что позволяет передать специфическое сообщение об ошибке вместе с типом ошибки.
 
 Конструктор `init(statusCode: Int, message: String?)` используется для создания экземпляра ошибки, основываясь на коде статуса HTTP-ответа и опциональном сообщении об ошибке. В зависимости от кода статуса выбирается соответствующий тип ошибки.
 
 Свойство `errorDescription` возвращает локализованное описание ошибки. В случае если для ошибки предоставлено специфическое сообщение, оно будет возвращено. В противном случае возвращается стандартное сообщение об ошибке для соответствующего типа ошибки.
 */

import Foundation

enum HTTPError: LocalizedError {
    case success
    case badRequest(String?)
    case unauthorized(String?)
    case paymentRequired(String?)
    case forbidden(String?)
    case notFound(String?)
    case methodNotAllowed(String?)
    case notAcceptable(String?)
    case requestTimeout(String?)
    case conflict(String?)
    case payloadTooLarge(String?)
    case unsupportedMediaType(String?)
    case tooManyRequests(String?)
    case internalServerError(String?)
    case badGateway(String?)
    case serviceUnavailable(String?)
    case gatewayTimeout(String?)
    case unexpectedStatusCode(Int, String?)
    case unknown(String?)
    case timeout(String?)
    case invalidURL(String?)
    case decodingError(String?)
    case noData(String?)
    
    init(statusCode: Int, message: String?) {
        switch statusCode {
        case 0:
            self = .invalidURL(message)
        case 200...299:
            self = .success
        case 400:
            self = .badRequest(message)
        case 401:
            self = .unauthorized(message)
        case 402:
            self = .paymentRequired(message)
        case 403:
            self = .forbidden(message)
        case 404:
            self = .notFound(message)
        case 405:
            self = .methodNotAllowed(message)
        case 406:
            self = .notAcceptable(message)
        case 408:
            self = .requestTimeout(message)
        case 409:
            self = .conflict(message)
        case 413:
            self = .payloadTooLarge(message)
        case 415:
            self = .unsupportedMediaType(message)
        case 429:
            self = .tooManyRequests(message)
        case 500:
            self = .internalServerError(message)
        case 502:
            self = .badGateway(message)
        case 503:
            self = .serviceUnavailable(message)
        case 504:
            self = .gatewayTimeout(message)
        default:
            self = .unexpectedStatusCode(statusCode, message)
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .success:
            return nil
        case .badRequest(let message):
            return message ?? "Неверный запрос"
        case .unauthorized(let message):
            return message ?? "Неавторизованный запрос"
        case .paymentRequired(let message):
            return message ?? "Требуется оплата"
        case .forbidden(let message):
            return message ?? "Запрос запрещен"
        case .notFound(let message):
            return message ?? "Запрашиваемый ресурс не найден"
        case .methodNotAllowed(let message):
            return message ?? "Метод не поддерживается"
        case .notAcceptable(let message):
            return message ?? "Неприемлемый запрос"
        case .requestTimeout(let message):
            return message ?? "Время запроса истекло"
        case .conflict(let message):
            return message ?? "Конфликт запроса"
        case .payloadTooLarge(let message):
            return message ?? "Слишком большой объем данных запроса"
        case .unsupportedMediaType(let message):
            return message ?? "Неподдерживаемый тип медиа данных"
        case .tooManyRequests(let message):
            return message ?? "Слишком много запросов"
        case .internalServerError(let message):
            return message ?? "Внутренняя ошибка сервера"
        case .badGateway(let message):
            return message ?? "Ошибка шлюза"
        case .serviceUnavailable(let message):
            return message ?? "Сервис недоступен"
        case .gatewayTimeout(let message):
            return message ?? "Время ожидания шлюза истекло"
        case .unexpectedStatusCode(let statusCode, let message):
            return message ?? "Неожиданный код статуса: \(statusCode)"
        case .unknown(let message):
            return message ?? "Неизвестная ошибка"
        case .timeout(let message):
            return message ?? "Превышено время ожидания от сервера"
        case .invalidURL(let message):
            return message ?? "Не удалось создать URL"
        case .decodingError(let message):
            return message ?? "Ошибка декодирования данных"
        case .noData(let message):
            return message ?? "Нет данных в ответе статускода"
        }
    }
    
    static func map(_ error: Error) -> Self {
        switch error {
        case let err as URLError:
            return HTTPError(statusCode: 0, message: err.localizedDescription)
            
        case let err as DecodingError:
            return .decodingError(err.localizedDescription)
            
        default:
            return .unknown(error.localizedDescription)
        }
    }
}
