//
//  CocktailEndpoint.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 14.05.23.
//

import Foundation

enum CocktailEndpoint {
    case fetchAllCocktails(token: String?, page: Int?, limit: Int?, ordering: String?, author: Int?, strengths: [String]?, tastes: [String]?, complexities: [String]?, formats: [String]?, ingredients: [String]?, isFavorited: Int?, name: String?, imgFormat: String?, imgSize: String?)
    case fetchCocktailSlug(slug: String, imgFormat: String?, imgSize: String?)
    case addCocktailToFavorites(token: String, slug: String)
    case removeCocktailFromFavorites(token: String, slug: String)
    case setCocktailRating(token: String, slug: String, rating: Int)
    case recipeSteps(token: String, ordering: String?, name: Int?)
    
    init() {
        self = .fetchAllCocktails(
            token: nil,
            page: nil,
            limit: nil,
            ordering: nil,
            author: nil,
            strengths: nil,
            tastes: nil,
            complexities: nil,
            formats: nil,
            ingredients: nil,
            isFavorited: nil,
            name: nil,
            imgFormat: nil,
            imgSize: nil
        )
    }
}

extension CocktailEndpoint: Endpoint {
    
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
        case .fetchAllCocktails:
            return "/api/cocktails/"
        case .fetchCocktailSlug(slug: let slug):
            return "/api/cocktails/\(slug)/"
        case .addCocktailToFavorites(token: _, slug: let slug):
            return "/api/cocktails/\(slug)/favorite/"
        case .removeCocktailFromFavorites(token: _, slug: let slug):
            return "/api/cocktails/\(slug)/favorite/"
        case .setCocktailRating(token: _, slug: let slug, rating: _):
            return "/api/cocktails/\(slug)/rating/"
        case .recipeSteps:
            return "/api/steps/"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .fetchAllCocktails(
            _,
            let page,
            let limit,
            let ordering,
            let author,
            let strengths,
            let tastes,
            let complexities,
            let formats,
            let ingredients,
            let isFavorited,
            let name,
            let imgFormat,
            let imgSize
        ):
            var queryItems = [URLQueryItem]()
            
            if let page = page {
                queryItems.append(URLQueryItem(name: "page", value: String(page)))
            }
            if let limit = limit {
                queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
            }
            if let ordering = ordering {
                queryItems.append(URLQueryItem(name: "ordering", value: ordering))
            }
            if let author = author {
                queryItems.append(URLQueryItem(name: "author", value: String(author)))
            }
            if let strengths = strengths {
                strengths.forEach { queryItems.append(URLQueryItem(name: "strengths", value: $0)) }
            }
            if let tastes = tastes {
                tastes.forEach { queryItems.append(URLQueryItem(name: "tastes", value: $0)) }
            }
            if let complexities = complexities {
                complexities.forEach { queryItems.append(URLQueryItem(name: "complexities", value: $0)) }
            }
            if let formats = formats {
                formats.forEach { queryItems.append(URLQueryItem(name: "formats", value: $0)) }
            }
            if let ingredients = ingredients {
                ingredients.forEach { queryItems.append(URLQueryItem(name: "ingredients", value: $0)) }
            }
            if let isFavorited = isFavorited {
                queryItems.append(URLQueryItem(name: "is_favorited", value: String(isFavorited)))
            }
            if let name = name {
                queryItems.append(URLQueryItem(name: "name", value: name))
            }
            if let imgFormat = imgFormat {
                queryItems.append(URLQueryItem(name: "img_format", value: imgFormat))
            }
            if let imgSize = imgSize {
                queryItems.append(URLQueryItem(name: "img_size", value: imgSize))
            }
            return queryItems
        case .fetchCocktailSlug(slug: _, imgFormat: let imgFormat, imgSize: let imgSize):
            var queryItems = [URLQueryItem]()
            
            if let imgFormat = imgFormat {
                queryItems.append(URLQueryItem(name: "img_format", value: imgFormat))
            }
            if let imgSize = imgSize {
                queryItems.append(URLQueryItem(name: "img_size", value: imgSize))
            }
            
            return queryItems
        case .addCocktailToFavorites:
            return []
        case .removeCocktailFromFavorites:
            return []
        case .setCocktailRating:
            return []
        case .recipeSteps(token: _, ordering: let ordering, name: let name):
            var queryItems = [URLQueryItem]()
            
            if let ordering = ordering {
                queryItems.append(URLQueryItem(name: "ordering", value: String(ordering)))
            }
            if let name = name {
                queryItems.append(URLQueryItem(name: "name", value: String(name)))
            }
            
            return queryItems
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .fetchAllCocktails:
            return .get
        case .fetchCocktailSlug:
            return .get
        case .addCocktailToFavorites:
            return .post
        case .removeCocktailFromFavorites:
            return .delete
        case .setCocktailRating:
            return .post
        case .recipeSteps:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .fetchAllCocktails(
            token: let token,
            page: _,
            limit: _,
            ordering: _,
            author: _,
            strengths: _,
            tastes: _,
            complexities: _,
            formats: _,
            ingredients: _,
            isFavorited: _,
            name: _,
            imgFormat: _,
            imgSize: _
        ):
            var headers = [String: String]()
            if let token = token {
                headers["Authorization"] = "Bearer \(token)"
            }
            return headers
        case .fetchCocktailSlug:
            return nil
        case .addCocktailToFavorites(token: let token, slug: _):
            return [
                "Authorization": "Bearer \(token)"
            ]
        case .removeCocktailFromFavorites(token: let token, slug: _):
            return [
                "Authorization": "Bearer \(token)"
            ]
        case .setCocktailRating(token: let token, slug: _, rating: _):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .recipeSteps(token: let token, ordering: _, name: _):
            return [
                "Accept": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .fetchAllCocktails:
            return nil
        case .fetchCocktailSlug:
            return nil
        case .addCocktailToFavorites:
            return nil
        case .removeCocktailFromFavorites:
            return nil
        case .setCocktailRating(token: _, slug: _, rating: let rating):
            
            let bodyParams: [String: Any] = [
                "rating": rating as Any
            ]
            return bodyParams
            
        case .recipeSteps:
            return nil
        }
    }
    
    var multipartFormData: [MultipartFormData]? {
        return nil
    }
}
