//
//  HTTPClient.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 13.05.23.
//
/*
 Вот что происходит в данном коде на Swift:
 
 1. Определяется протокол `HTTPClient`, который описывает метод `sendRequest(endpoint:responseModel:)`, который должен быть реализован в любом типе, поддерживающем этот протокол. Метод используется для отправки HTTP-запроса и получения ответа. Он принимает объект, реализующий протокол `Endpoint` (который был определён в предыдущем коде) и тип модели ответа `T.Type` (где `T` - это любой тип, поддерживающий протокол `Codable`). Метод возвращает `Result<T, HTTPError>`, где `T` - это ожидаемый тип данных ответа, а `HTTPError` - это тип ошибки.
 
 2. `HTTPClient` расширяется реализацией по умолчанию для метода `sendRequest(endpoint:responseModel:)`. Этот метод формирует URL запроса, создает URLRequest, преобразует параметры запроса в тело запроса (если они есть), выполняет запрос, обрабатывает ответ сервера и преобразует его в ожидаемую модель ответа или объект ошибки.
 
 3. В расширении `HTTPClient` определена вспомогательная функция `createBody(parameters:boundary:data:mimeType:filename:)`, которая используется для создания тела запроса типа `multipart/form-data`. Это обычно используется при загрузке файлов на сервер.
 
 4. `NSMutableData` расширяется методом `appendString(_:)`, который преобразует строку в `Data` и добавляет ее к существующим данным.
 
 В целом, этот код представляет собой реализацию простого HTTP-клиента, который может отправлять HTTP-запросы и обрабатывать их ответы. Он также поддерживает загрузку файлов на сервер, используя `multipart/form-data` запросы.
 */

import Foundation
import Combine

// (URL) -> URLRequest

// (URLRequest) -> URLRequest

// (URLRequest) -> URLSession

// (URLRequest) -> (Data, URLRequest)

// (URLSession) -> AnyPublisher<(data: Data, response: URLResponse), Error>

// (AnyPublisher<(data: Data, response: URLResponse), Error>) -> AnyPublisher<T, HTTPError>

// () -> AnyPublisher<T, HTTPError>
// (String) -> AnyPublisher<T, HTTPError>
// (String, Int) -> -> AnyPublisher<T, HTTPError>

// (A) -> B
// (B) -> C

// (A) -> C
func compose<A,B,C>(
    _ f: @escaping (A) -> B,
    _ g: @escaping (B) -> C
) -> (A) -> C {
    { g(f($0)) }
}

func compose<A,B,C, D>(
    _ f: @escaping (A) -> B,
    _ g: @escaping (B) -> C,
    _ h: @escaping (C) -> D
) -> (A) -> D {
    { h(g(f($0))) }
}

struct ApiClient {
    typealias Request = (URLRequest) -> URLRequest
    typealias DataPublisher = AnyPublisher<(data: Data, response: URLResponse), Error>
    
    func downloadRequest<T: Codable>(endpoint: Endpoint) -> AnyPublisher<T, HTTPError> {
        let session = makeSession()
        return compose(
            composeRequest(),
            downloadTaskPublisher(session)
        )(endpoint)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError(HTTPError.map)
            .eraseToAnyPublisher()
    }
}

private extension ApiClient {
    func makeSession() -> URLSession {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = Constants.timeOfTimeout
        return URLSession(configuration: config)
    }
    
    func uploadTaskPublisher(_ session: URLSession = .shared) -> (URLRequest, Data) -> DataPublisher {
        { request, data in
            Future <(data: Data, response: URLResponse), Error> { promise in
                Task {
                    do {
                        let result = try await session.upload(for: request, from: data)
                        promise(.success(result))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            .eraseToAnyPublisher()
        }
    }
    
    func downloadTaskPublisher(_ session: URLSession = .shared) -> (URLRequest) -> DataPublisher {
        { request in
            URLSession
                .DataTaskPublisher(request: request, session: session)
                .mapError { $0 }
                .eraseToAnyPublisher()
        }
    }
    
    func composeRequest() -> (Endpoint) -> URLRequest {
        { endpoint in
            compose(
                makeURL(),
                makeRequest(with: endpoint),
                configure(headers: endpoint.header)
            )(endpoint)
        }
    }
    
    func makeURL() -> (Endpoint) -> URL {
        { endpoint in
            var components = URLComponents()
            components.scheme = endpoint.scheme
            components.path = endpoint.path
            components.host = endpoint.host
            if !endpoint.parameters.isEmpty {
                components.queryItems = endpoint.parameters
            }
            guard let url = components.url else {
                preconditionFailure("Unable to create URL from: \(components)")
            }
            return url
        }
    }
    
    func makeRequest(with endpoint: Endpoint) -> (URL) -> URLRequest {
        {
            var request = URLRequest(url: $0)
            request.httpMethod = endpoint.method.rawValue
            return request
        }
    }
    
    func configure(headers: [String: String]?) -> Request {
        {
            var request = $0
            request.allHTTPHeaderFields = headers
            return request
        }
    }
}

protocol HTTPClient {
    func sendRequest<T: Codable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, HTTPError>
}

extension HTTPClient {
    func sendRequest<T: Codable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, HTTPError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        if !endpoint.parameters.isEmpty {
            urlComponents.queryItems = endpoint.parameters
        }
        
        guard let url = urlComponents.url else {
            return .failure(HTTPError(statusCode: 0, message: "Неверно создан URL"))
        }
        
        // Печатаем ссылку запроса
        print("Делаем запрос по адресу", url)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        // Печатаем хэдэр
        // print("Хэдер запроса содержит =", request.allHTTPHeaderFields ?? [:])
        
        if let formData = endpoint.multipartFormData {
            let stringParameters = endpoint.body?.compactMapValues { String(describing: $0) }
            let boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = createBody(parameters: stringParameters,
                                          boundary: boundary,
                                          data: formData, // здесь теперь передается массив
                                          mimeType: nil, // mimeType и filename теперь обрабатываются внутри createBody
                                          filename: nil)
        } else if let body = endpoint.body {
            // Печатаем содержимое body
            // print("Боди запроса содержит =", body)
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        func createBody(parameters: [String: String]?,
                        boundary: String,
                        data: [MultipartFormData],
                        mimeType: String?,
                        filename: String?) -> Data {
            let body = NSMutableData()
            
            let boundaryPrefix = "--\(boundary)\r\n"
            
            if let parameters = parameters {
                for (key, value) in parameters {
                    body.appendString(boundaryPrefix)
                    body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.appendString("\(value)\r\n")
                }
            }
            
            for formData in data {
                body.appendString(boundaryPrefix)
                body.appendString("Content-Disposition: form-data; name=\"\(formData.name)\"")
                if let filename = formData.fileName {
                    body.appendString("; filename=\"\(filename)\"")
                }
                body.appendString("\r\n")
                if let mimeType = formData.mimeType {
                    body.appendString("Content-Type: \(mimeType)\r\n\r\n")
                } else {
                    body.appendString("\r\n")
                }
                body.append(formData.data)
                body.appendString("\r\n")
            }
            
            body.appendString("--".appending(boundary.appending("--")))
            
            return body as Data
        }
        
        // print("Печатаем боди реквеста", request.httpBody?.prettyJSON as Any)
        
        // Настраиваем таймаут
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Constants.timeOfTimeout // Задаем таймаут
        let session = URLSession(configuration: configuration)
        
        do {
            let (data, response) = try await session.data(for: request, delegate: nil)
            //print(data.prettyJSON as Any)
            guard let response = response as? HTTPURLResponse else {
                return .failure(HTTPError.unexpectedStatusCode(0, "Сервер вернул неожиданный тип ответа (не HTTPURLResponse)"))
            }
            
            if response.statusCode >= 200 && response.statusCode <= 299 {
                if data.isEmpty {
                    let emptyResponse = AnyAnswerModel(anyAnswer: "Удачный пустой ответ")
                    return .success(emptyResponse as! T)
                } else {
                    do {
                        let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                        print("В общем запросе вернулся 200-299 код")
                        return .success(decodedResponse)
                    } catch {
                        return .failure(HTTPError.decodingError("Не удалось преобразовать данные ответа в модель: \(error.localizedDescription)"))
                    }
                }
            } else {
                if data.isEmpty {
                    return .failure(HTTPError.noData("Нет данных в ответе"))
                } else {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any],
                           let firstKey = dictionary.keys.first,
                           let firstValue = dictionary[firstKey] as? String {
                            let decodedError = AnyAnswerModel(anyAnswer: firstValue)
                            return .failure(HTTPError(statusCode: response.statusCode, message: decodedError.anyAnswer))
                        } else {
                            return .failure(HTTPError.decodingError("Невозможно преобразовать данные ошибки в модель"))
                        }
                    } catch {
                        return .failure(HTTPError.decodingError("Не удалось преобразовать данные ошибки в модель: \(error.localizedDescription)"))
                    }
                }
            }
        } catch {
            if let error = error as? URLError, error.code == .timedOut {
                print("Ошибка таймаута при выполнении запроса:", error)
                return .failure(HTTPError.timeout("Превышено время ожидания от сервера"))
            } else {
                print("Необработанная ошибка при выполнении запроса:", error)
                return .failure(HTTPError.unknown("Неизвестная ошибка: \(error.localizedDescription)"))
            }
        }
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
