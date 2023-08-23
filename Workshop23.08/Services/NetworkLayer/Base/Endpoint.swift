//
//  Endpoint.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 13.05.23.
//
/*
 Этот код представляет собой основу для реализации модели запросов HTTP в Swift. Здесь применяется протокол `Endpoint`, который определяет все необходимые свойства для создания HTTP-запроса.
 
 1. `scheme`: Это схема URL-запроса (например, "http" или "https").
 2. `host`: Это хост, к которому вы делаете запрос. Обычно это доменное имя сайта.
 3. `path`: Путь к конкретному ресурсу на сайте, к которому вы делаете запрос.
 4. `parameters`: Параметры, которые передаются в URL-запросе.
 5. `method`: HTTP метод, который вы используете для запроса. Здесь метод определен другим протоколом/перечислением, который не представлен в данном коде.
 6. `header`: Заголовки HTTP-запроса.
 7. `body`: Тело HTTP-запроса.
 8. `multipartFormData`: Это опциональный параметр, используемый в случае, если вы хотите отправить файл или данные формы с использованием формата "multipart/form-data".
 
 `MultipartFormData` структура используется для обработки форматов данных "multipart/form-data", которые обычно используются при отправке файлов:
 
 1. `data`: Это сами данные, которые нужно отправить.
 2. `name`: Имя поля формы.
 3. `fileName`: Это опциональное свойство, которое используется, если данные представляют собой файл. Здесь вы указываете имя файла.
 4. `mimeType`: Тип данных, которые отправляются. Это опциональное свойство, которое часто используется при отправке файлов для указания их типа.
 */


import Foundation

struct Endpoint1 {
    let path: String
    var queryItems: [URLQueryItem] = .init()
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constants.baseURL
        components.path = path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            preconditionFailure("Unable to create URL from: \(components)")
        }
        
        return url
    }
    
    static let recipeSteps = Self(path: "/api/steps/")
    
    static func getAllCocktails(_ filters: [String: String] = .init()) -> Self {
        .init(
            path: "/api/cocktails/",
            queryItems: []
        )
    }
    
    static func getCocktail(withSlug slug: String) -> Self {
        .init(path: "/api/cocktails/\(slug)")
    }
    
    static func addCocktailToFavorites(slug: String) -> Self {
        .init(path: "/api/cocktails/\(slug)/favorite")
    }
    
    static func removeCocktailFromFavorites(slug: String) -> Self {
        .init(path: "/api/cocktails/\(slug)/favorite/")
    }
    
    static func setCocktailRating(slug: String) -> Self {
        .init(path: "/api/cocktails/\(slug)/rating/")
    }
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
    var multipartFormData: [MultipartFormData]? { get }
}

struct MultipartFormData: Codable, Hashable {
    var data: Data
    var name: String
    var fileName: String?
    var mimeType: String?
}
