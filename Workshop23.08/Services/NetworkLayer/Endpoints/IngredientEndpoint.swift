//
//  IngredientEndpoint.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 21.05.23.
//

import Foundation

enum IngredientEndpoint {
    case fetchAllIngredients(token: String?, page: Int?, limit: Int?, ordering: String?, strengthMin: Int?, strengthMax: Int?, tastes: [String]?, categories: [String]?, isInMyBar: Int?, isInShoppingList: Int?, name: String?, imgFormat: String?, imgSize: String?)
    case fetchAllIngredientsShort(token: String?, page: Int?, limit: Int?, ordering: String?, strengthMin: Int?, strengthMax: Int?, tastes: [String]?, categories: [String]?, isInMyBar: Int?, isInShoppingList: Int?, name: String?, imgFormat: String?, imgSize: String?)
    case shoppingListOfIngredients(token: String, page: Int?, limit: Int?, imgFormat: String?, imgSize: String?)
    case addIngredientToShoppingList(token: String, slug: String)
    case removeIngredientFromShoppingList(token: String, slug: String)
    case unitsOfMeasurement(token: String, ordering: String?, name: Int?)
    case addIngredienToBar(token: String, slug: String)
    case removeIngredientFromBar(token: String, slug: String)
    case fetchIngredientSlug(slug: String, imgFormat: String?, imgSize: String?)
    case fetchListOfIngredientCategories(page: Int?, limit: Int?, ordering: String?, name: String?)
    case fetchIngredientCategorySlug(slug: String)
}

extension IngredientEndpoint: Endpoint {
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
        case .fetchAllIngredients:
            return "/api/ingredients/"
        case .shoppingListOfIngredients:
            return "/api/shopping_list/"
        case .addIngredientToShoppingList(token: _, slug: let slug):
            return "/api/ingredients/\(slug)/shopping_list/"
        case .removeIngredientFromShoppingList(token: _, slug: let slug):
            return "/api/ingredients/\(slug)/shopping_list/"
        case .unitsOfMeasurement:
            return "/api/units/"
        case .addIngredienToBar(token: _, slug: let slug):
            return "/api/ingredients/\(slug)/bar/"
        case .removeIngredientFromBar(token: _, slug: let slug):
            return "/api/ingredients/\(slug)/bar/"
        case .fetchIngredientSlug(slug: let slug):
            return "/api/ingredients/\(slug)/"
        case .fetchListOfIngredientCategories:
            return "/api/ingredients/categories/"
        case .fetchIngredientCategorySlug(slug: let slug):
            return "/api/ingredients/categories/\(slug)/"
        case .fetchAllIngredientsShort:
            return "/api/ingredients/short_list/"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .fetchAllIngredients(token: _, page: let page, limit: let limit, ordering: let ordering, strengthMin: let strengthMin, strengthMax: let strengthMax, tastes: let tastes, categories: let categories, isInMyBar: let isInMyBar, isInShoppingList: let isInShoppingList, name: let name, imgFormat: let imgFormat, imgSize: let imgSize),
                .fetchAllIngredientsShort(token: _, page: let page, limit: let limit, ordering: let ordering, strengthMin: let strengthMin, strengthMax: let strengthMax, tastes: let tastes, categories: let categories, isInMyBar: let isInMyBar, isInShoppingList: let isInShoppingList, name: let name, imgFormat: let imgFormat, imgSize: let imgSize):
            
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
            if let strengthMin = strengthMin {
                queryItems.append(URLQueryItem(name: "strength_min", value: String(strengthMin)))
            }
            if let strengthMax = strengthMax {
                queryItems.append(URLQueryItem(name: "strength_max", value: String(strengthMax)))
            }
            if let tastes = tastes {
                tastes.forEach { queryItems.append(URLQueryItem(name: "tastes", value: $0)) }
            }
            if let categories = categories {
                categories.forEach { queryItems.append(URLQueryItem(name: "categories", value: $0)) }
            }
            if let isInMyBar = isInMyBar {
                queryItems.append(URLQueryItem(name: "is_in_my_bar", value: String(isInMyBar)))
            }
            if let isInShoppingList = isInShoppingList {
                queryItems.append(URLQueryItem(name: "is_in_shopping_list", value: String(isInShoppingList)))
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
        case .shoppingListOfIngredients(token: _, page: let page, limit: let limit, imgFormat: let imgFormat, imgSize: let imgSize):
            var queryItems = [URLQueryItem]()
            
            if let page = page {
                queryItems.append(URLQueryItem(name: "page", value: String(page)))
            }
            if let limit = limit {
                queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
            }
            if let imgFormat = imgFormat {
                queryItems.append(URLQueryItem(name: "img_format", value: imgFormat))
            }
            if let imgSize = imgSize {
                queryItems.append(URLQueryItem(name: "img_size", value: imgSize))
            }
            return queryItems
        case .addIngredientToShoppingList:
            return []
        case .removeIngredientFromShoppingList:
            return []
        case .unitsOfMeasurement(token: _, ordering: let ordering, name: let name):
            var queryItems = [URLQueryItem]()
            
            if let ordering = ordering {
                queryItems.append(URLQueryItem(name: "ordering", value: String(ordering)))
            }
            if let name = name {
                queryItems.append(URLQueryItem(name: "name", value: String(name)))
            }
            
            return queryItems
        case .addIngredienToBar:
            return []
        case .removeIngredientFromBar:
            return []
        case .fetchIngredientSlug(slug: _, imgFormat: let imgFormat, imgSize: let imgSize):
            var queryItems = [URLQueryItem]()
            
            if let imgFormat = imgFormat {
                queryItems.append(URLQueryItem(name: "img_format", value: imgFormat))
            }
            if let imgSize = imgSize {
                queryItems.append(URLQueryItem(name: "img_size", value: imgSize))
            }
            
            return queryItems
        case .fetchListOfIngredientCategories(page: let page, limit: let limit, ordering: let ordering, name: let name):
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
            if let name = name {
                queryItems.append(URLQueryItem(name: "name", value: name))
            }
            
            return queryItems
        case .fetchIngredientCategorySlug:
            return []
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .fetchAllIngredients:
            return .get
        case .shoppingListOfIngredients:
            return .get
        case .addIngredientToShoppingList:
            return .post
        case .removeIngredientFromShoppingList:
            return .delete
        case .unitsOfMeasurement:
            return .get
        case .addIngredienToBar:
            return .post
        case .removeIngredientFromBar:
            return .delete
        case .fetchIngredientSlug:
            return .get
        case .fetchListOfIngredientCategories:
            return .get
        case .fetchIngredientCategorySlug:
            return .get
        case .fetchAllIngredientsShort:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .fetchAllIngredients(token: let token, page: _, limit: _, ordering: _, strengthMin: _, strengthMax: _, tastes: _, categories: _, isInMyBar: _, isInShoppingList: _, name: _, imgFormat: _, imgSize: _):
            var headers = [String: String]()
            if let token = token {
                headers["Authorization"] = "Bearer \(token)"
            }
            return headers
        case .shoppingListOfIngredients(token: let token, page: _, limit: _, imgFormat: _, imgSize: _):
            return [
                "Accept": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .addIngredientToShoppingList(token: let token, slug: _):
            return [
                "Authorization": "Bearer \(token)"
            ]
        case .removeIngredientFromShoppingList(token: let token, slug: _):
            return [
                "Authorization": "Bearer \(token)"
            ]
        case .unitsOfMeasurement(token: let token, ordering: _, name: _):
            return [
                "Accept": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .addIngredienToBar(token: let token, slug: _):
            return [
                "Authorization": "Bearer \(token)"
            ]
        case .removeIngredientFromBar(token: let token, slug: _):
            return [
                "Authorization": "Bearer \(token)"
            ]
        case .fetchIngredientSlug:
            return nil
        case .fetchListOfIngredientCategories:
            return nil
        case .fetchIngredientCategorySlug:
            return nil
        case .fetchAllIngredientsShort(token: let token, page: _, limit: _, ordering: _, strengthMin: _, strengthMax: _, tastes: _, categories: _, isInMyBar: _, isInShoppingList: _, name: _, imgFormat: _, imgSize: _):
            var headers = [String: String]()
            if let token = token {
                headers["Authorization"] = "Bearer \(token)"
            }
            return headers
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .fetchAllIngredients:
            return nil
        case .shoppingListOfIngredients:
            return nil
        case .addIngredientToShoppingList:
            return nil
        case .removeIngredientFromShoppingList:
            return nil
        case .unitsOfMeasurement:
            return nil
        case .addIngredienToBar:
            return nil
        case .removeIngredientFromBar:
            return nil
        case .fetchIngredientSlug:
            return nil
        case .fetchListOfIngredientCategories:
            return nil
        case .fetchIngredientCategorySlug:
            return nil
        case .fetchAllIngredientsShort:
            return nil
        }
    }
    
    var multipartFormData: [MultipartFormData]? {
        return nil
    }
}
