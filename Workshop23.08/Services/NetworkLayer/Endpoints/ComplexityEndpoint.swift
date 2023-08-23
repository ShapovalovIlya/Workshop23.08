//
//  ComplexityEndpoint.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 22.05.23.
//

import Foundation

enum ComplexityEndpoint {
    case fetchAllComplexities(page: Int?, limit: Int?, ordering: String?, name: String?)
    case fetchСomplexitySlug(slug: String)
}

extension ComplexityEndpoint: Endpoint {
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
        case .fetchAllComplexities:
            return "/api/cocktails/complexities/"
        case .fetchСomplexitySlug(slug: let slug):
            return "/api/cocktails/complexities/\(slug)/"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .fetchAllComplexities(let page, let limit, let ordering, let name):
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
        case .fetchСomplexitySlug:
            return []
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
        default:
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
