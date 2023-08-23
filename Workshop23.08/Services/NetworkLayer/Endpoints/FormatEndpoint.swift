//
//  FormatEndpoint.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 22.05.23.
//

import Foundation

enum FormatEndpoint {
    case fetchAllFormats(page: Int?, limit: Int?, ordering: String?, name: String?, imgFormat: String?, imgSize: String?)
    case fetchFormatSlug(slug: String, imgFormat: String?, imgSize: String?)
}

extension FormatEndpoint: Endpoint {
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
        case .fetchAllFormats:
            return "/api/cocktails/formats/"
        case .fetchFormatSlug(slug: let slug):
            return "/api/cocktails/formats/\(slug)/"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .fetchAllFormats(let page, let limit, let ordering, let name, let imgFormat, let imgSize):
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
            if let imgFormat = imgFormat {
                queryItems.append(URLQueryItem(name: "img_format", value: imgFormat))
            }
            if let imgSize = imgSize {
                queryItems.append(URLQueryItem(name: "img_size", value: imgSize))
            }
            return queryItems
        case .fetchFormatSlug(slug: _, imgFormat: let imgFormat, imgSize: let imgSize):
            var queryItems = [URLQueryItem]()
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
