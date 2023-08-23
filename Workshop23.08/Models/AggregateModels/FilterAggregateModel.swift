//
//  FilterAggregateModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 22.05.23.
//

import Foundation

@MainActor
class FilterAggregateModel: ObservableObject {
    
    let filtersService: FiltersService
    
    @Published var tasteList: [Taste] = []
    @Published var taste: Taste?
    @Published var formatList: [Format] = []
    @Published var format: Format?
    @Published var complexityList: [Complexity] = []
    @Published var complexity: Complexity?
    @Published var strengthList: [Strength] = []
    @Published var strength: Strength?
    @Published var inventoryList: [Inventory] = []
    @Published var inventory: Inventory?
    @Published var cocktails: [Global]?
    @Published var ingredients: [Global]?
    
    init(filtersService: FiltersService) {
        self.filtersService = filtersService
    }

    func getTasteList(page: Int? = nil, limit: Int? = nil, ordering: String? = nil, name: String? = nil) async throws {
        
        let queryResult = await filtersService.getAllTastes(page: page, limit: limit, ordering: ordering, name: name)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе getTasteList")
            tasteList = result.results ?? []
            print("Кол-во вкусов", tasteList.count)
        case .failure(let error):
            print("Получили ошибку запроса getTasteList:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func fetchTasteSlug(slug: String) async throws {
        
        let queryResult = await filtersService.fetchTasteSlug(slug: slug)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе fetchTasteSlug")
            taste = result
            print("Название вкуса =", taste?.name ?? "Нет там ничего по слагу")
        case .failure(let error):
            print("Получили ошибку запроса fetchTasteSlug:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func getFormatList(page: Int? = nil, limit: Int? = nil, ordering: String? = nil, name: String? = nil, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await filtersService.getAllFormats(page: page, limit: limit, ordering: ordering, name: name, imgFormat: imgFormat, imgSize: imgSize)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе getFormatList")
            formatList = result.results ?? []
            print("Кол-во форматов", formatList.count)
        case .failure(let error):
            print("Получили ошибку запроса getFormatList:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func fetchFormatSlug(slug: String, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await filtersService.fetchFormatSlug(slug: slug, imgFormat: imgFormat, imgSize: imgSize)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе fetchFormatSlug")
            format = result
            print("Название вкуса =", format?.name ?? "Нет там ничего по слагу")
        case .failure(let error):
            print("Получили ошибку запроса fetchFormatSlug:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func getComplexityList(page: Int? = nil, limit: Int? = nil, ordering: String? = nil, name: String? = nil) async throws {
        
        let queryResult = await filtersService.getAllComplexities(page: page, limit: limit, ordering: ordering, name: name)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе fetchFormatSlug")
            complexityList = result.results ?? []
            print("Кол-во сложностей", complexityList.count)
        case .failure(let error):
            print("Получили ошибку запроса fetchFormatSlug:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func fetchСomplexitySlug(slug: String) async throws {
        
        let queryResult = await filtersService.fetchСomplexitySlug(slug: slug)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе fetchСomplexitySlug")
            complexity = result
            print("Название вкуса =", complexity?.name ?? "Нет там ничего по слагу")
        case .failure(let error):
            print("Получили ошибку запроса fetchСomplexitySlug:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func getStrengthList(page: Int? = nil, limit: Int? = nil, ordering: String? = nil, name: String? = nil) async throws {
        
        let queryResult = await filtersService.getAllStrengths(page: page, limit: limit, ordering: ordering, name: name)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе getStrengthList")
            strengthList = result.results ?? []
            print("Кол-во крепости", strengthList.count)
        case .failure(let error):
            print("Получили ошибку запроса getInventoryList:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func fetchStrengthSlug(slug: String) async throws {
        
        let queryResult = await filtersService.fetchStrengthSlug(slug: slug)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе fetchStrengthSlug")
            strength = result
            print("Название крепости =", strength?.name ?? "Нет там ничего по слагу")
        case .failure(let error):
            print("Получили ошибку запроса fetchStrengthSlug:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func getInventoryList(page: Int? = nil, limit: Int? = nil, ordering: String? = nil, name: String? = nil, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await filtersService.getAllInventory(page: page, limit: limit, ordering: ordering, name: name, imgFormat: imgFormat, imgSize: imgSize)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе getInventoryList")
            inventoryList = result.results ?? []
            print("Кол-во инвентаря =", result.count ?? 0)
        case .failure(let error):
            print("Получили ошибку запроса getInventoryList:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func fetchInventorySlug(slug: String, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await filtersService.fetchInventorySlug(slug: slug, imgFormat: imgFormat, imgSize: imgSize)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе fetchInventorySlug")
            inventory = result
            print("Название инвентаря =", inventory?.name ?? "Нет там ничего по слагу")
        case .failure(let error):
            print("Получили ошибку запроса fetchInventorySlug:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func globalSearch(query: String?, page: Int? = nil, limit: Int? = nil, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await filtersService.globalSearch(query: query, page: page, limit: limit, imgFormat: imgFormat, imgSize: imgSize)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе globalSearch")
            if let results = result.results {
                cocktails = results.filter { $0.object == "cocktail" }
                ingredients = results.filter { $0.object == "ingredient" }
            }
            print("Кол-во ответов в поиске =", result.count ?? 0)
            print("Кол-во коктейлей в поиске =", cocktails?.count ?? 0)
            print("Кол-во ингридиентов в поиске =", ingredients?.count ?? 0)
        case .failure(let error):
            print("Получили ошибку запроса globalSearch:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
}
