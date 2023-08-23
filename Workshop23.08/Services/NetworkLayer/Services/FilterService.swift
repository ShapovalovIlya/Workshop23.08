//
//  FilterService.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 22.05.23.
//

import Foundation

protocol FiltersServiceable {
    func getAllTastes(page: Int?, limit: Int?, ordering: String?, name: String?) async -> Result<TasteModel, HTTPError>
    func fetchTasteSlug(slug: String) async -> Result<Taste, HTTPError>
    func getAllFormats(page: Int?, limit: Int?, ordering: String?, name: String?, imgFormat: String?, imgSize: String?) async -> Result<FormatModel, HTTPError>
    func fetchFormatSlug(slug: String, imgFormat: String?, imgSize: String?) async -> Result<Format, HTTPError>
    func getAllComplexities(page: Int?, limit: Int?, ordering: String?, name: String?) async -> Result<ComplexityModel, HTTPError>
    func fetchСomplexitySlug(slug: String) async -> Result<Complexity, HTTPError>
    func getAllStrengths(page: Int?, limit: Int?, ordering: String?, name: String?) async -> Result<StrengthModel, HTTPError>
    func fetchStrengthSlug(slug: String) async -> Result<Strength, HTTPError>
    func getAllInventory(page: Int?, limit: Int?, ordering: String?, name: String?, imgFormat: String?, imgSize: String?) async -> Result<InventoryModel, HTTPError>
    func fetchInventorySlug(slug: String, imgFormat: String?, imgSize: String?) async -> Result<Inventory, HTTPError>
    func globalSearch(query: String?, page: Int?, limit: Int?, imgFormat: String?, imgSize: String?) async -> Result<GlobalModel, HTTPError>
}

class FiltersService: HTTPClient, FiltersServiceable {

    func getAllTastes(page: Int?, limit: Int?, ordering: String?, name: String?) async -> Result<TasteModel, HTTPError> {
        return await sendRequest(endpoint: TasteEndpoint.fetchAllTastes(page: page, limit: limit, ordering: ordering, name: name), responseModel: TasteModel.self)
    }
    
    func getAllFormats(page: Int?, limit: Int?, ordering: String?, name: String?, imgFormat: String?, imgSize: String?) async -> Result<FormatModel, HTTPError> {
        return await sendRequest(endpoint: FormatEndpoint.fetchAllFormats(page: page, limit: limit, ordering: ordering, name: name, imgFormat: imgFormat, imgSize: imgSize), responseModel: FormatModel.self)
    }
    
    func getAllComplexities(page: Int?, limit: Int?, ordering: String?, name: String?) async -> Result<ComplexityModel, HTTPError> {
        return await sendRequest(endpoint: ComplexityEndpoint.fetchAllComplexities(page: page, limit: limit, ordering: ordering, name: name), responseModel: ComplexityModel.self)
    }
    
    func getAllStrengths(page: Int?, limit: Int?, ordering: String?, name: String?) async -> Result<StrengthModel, HTTPError> {
        return await sendRequest(endpoint: StrengthEndpoint.fetchAllStrengths(page: page, limit: limit, ordering: ordering, name: name), responseModel: StrengthModel.self)
    }
    
    func getAllInventory(page: Int?, limit: Int?, ordering: String?, name: String?, imgFormat: String?, imgSize: String?) async -> Result<InventoryModel, HTTPError> {
        return await sendRequest(endpoint: InventoryEndpoint.fetchAllInventory(page: page, limit: limit, ordering: ordering, name: name, imgFormat: imgFormat, imgSize: imgSize), responseModel: InventoryModel.self)
    }
    
    func fetchInventorySlug(slug: String, imgFormat: String?, imgSize: String?) async -> Result<Inventory, HTTPError> {
        return await sendRequest(endpoint: InventoryEndpoint.fetchInventorySlug(slug: slug, imgFormat: imgFormat, imgSize: imgSize), responseModel: Inventory.self)
    }
    
    func fetchStrengthSlug(slug: String) async -> Result<Strength, HTTPError> {
        return await sendRequest(endpoint: StrengthEndpoint.fetchStrengthSlug(slug: slug), responseModel: Strength.self)
    }
    
    func fetchTasteSlug(slug: String) async -> Result<Taste, HTTPError> {
        return await sendRequest(endpoint: TasteEndpoint.fetchTasteSlug(slug: slug), responseModel: Taste.self)
    }
    
    func fetchFormatSlug(slug: String, imgFormat: String?, imgSize: String?) async -> Result<Format, HTTPError> {
        return await sendRequest(endpoint: FormatEndpoint.fetchFormatSlug(slug: slug, imgFormat: imgFormat, imgSize: imgSize), responseModel: Format.self)
    }
    
    func fetchСomplexitySlug(slug: String) async -> Result<Complexity, HTTPError> {
        return await sendRequest(endpoint: ComplexityEndpoint.fetchСomplexitySlug(slug: slug), responseModel: Complexity.self)
    }
    
    func globalSearch(query: String?, page: Int?, limit: Int?, imgFormat: String?, imgSize: String?) async -> Result<GlobalModel, HTTPError> {
        return await sendRequest(endpoint: BarEndpoint.globalSearch(query: query, page: page, limit: limit, imgFormat: imgFormat, imgSize: imgSize), responseModel: GlobalModel.self)
    }
    
}
