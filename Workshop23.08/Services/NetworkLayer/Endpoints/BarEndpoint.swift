//
//  BarEndpoint.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 3.06.23.
//

import Foundation

enum BarEndpoint {
    case cocktailRecommendationsList(token: String, page: Int?, limit: Int?, imgFormat: String?, imgSize: String?)
    case globalSearch(query: String?, page: Int?, limit: Int?, imgFormat: String?, imgSize: String?)
}

extension BarEndpoint: Endpoint {
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
        case .cocktailRecommendationsList:
            return "/api/bar/"
        case .globalSearch:
            return "/api/search/"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .cocktailRecommendationsList(token: _, page: let page, limit: let limit, imgFormat: let imgFormat, imgSize: let imgSize):
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
        case .globalSearch(query: let query, page: let page, limit: let limit, imgFormat: let imgFormat, imgSize: let imgSize):
            var queryItems = [URLQueryItem]()
            
            if let query = query {
                queryItems.append(URLQueryItem(name: "query", value: String(query)))
            }
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
        }
    }
    
    var method: RequestMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .cocktailRecommendationsList(token: let token, page: _, limit: _, imgFormat: _, imgSize: _):
            return [
                "Authorization": "Bearer \(token)"
            ]
        case .globalSearch:
            return nil
        }
    }
    
    var body: [String : Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var multipartFormData: [MultipartFormData]? {
        return nil
    }
}
