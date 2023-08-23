//
//  CocktailAggregateModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 17.05.23.
//

import Foundation
//import Combine

@MainActor
class CocktailAggregateModel: ObservableObject {
    
    let cocktailService: CoctailsService
    
    @Published var cocktailList: [Cocktail] = []
    @Published var cocktail: Cocktail?
    @Published var stepsList: [Step] = []
    
    init(cocktailService: CoctailsService) {
        self.cocktailService = cocktailService
    }
    
    func getСocktailList(token: String? = nil, page: Int? = nil, limit: Int? = nil, ordering: String? = nil, author: Int? = nil, strengths: [String]? = nil, tastes: [String]? = nil, complexities: [String]? = nil, formats: [String]? = nil, ingredients: [String]? = nil, isFavorited: Int? = nil, name: String? = nil, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await cocktailService.getAllCoctails(token: token, page: page, limit: limit, ordering: ordering, author: author, strengths: strengths, tastes: tastes, complexities: complexities, formats: formats, ingredients: ingredients, isFavorited: isFavorited, name: name, imgFormat: imgFormat, imgSize: imgSize)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе getСocktailList")
            cocktailList = result.results ?? []
            print("Кол-во коктейлей", cocktailList.count)
        case .failure(let error):
            print("Получили ошибку запроса getСocktailList:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func cocktailRecommendationsList(token: String, page: Int? = nil, limit: Int? = nil, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await cocktailService.cocktailRecommendationsList(token: token, page: page, limit: limit, imgFormat: imgFormat, imgSize: imgSize)
        
        switch queryResult {
            case .success(_):
            print("Получили Result в запросе cocktailRecommendationsList")
//            cocktailList = result.results ?? []
            print("Кол-во коктейлей в подборе коктейлей", cocktailList.count)
        case .failure(let error):
            print("Получили ошибку запроса cocktailRecommendationsList:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func fetchCocktailSlug(slug: String, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await cocktailService.fetchCocktailSlug(slug: slug, imgFormat: imgFormat, imgSize: imgSize)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе fetchCocktailSlug")
            cocktail = result
            print("Название коктейля =", cocktail?.name ?? "Нет там ничего по слагу")
        case .failure(let error):
            print("Получили ошибку запроса fetchCocktailSlug:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func addCocktailToFavorites(token: String, slug: String) async throws {
        
        let queryResult = await cocktailService.addCocktailToFavorites(token: token, slug: slug)
        
        switch queryResult {
        case .success:
            print("Получили Result в запросе addCocktailToFavorites")
            print("Коктейль успешно добавлен в избранное")
        case .failure(let error):
            print("Получили ошибку запроса addCocktailToFavorites:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func removeCocktailFromFavorites(token: String, slug: String) async throws {
        
        let queryResult = await cocktailService.removeCocktailFromFavorites(token: token, slug: slug)
        
        switch queryResult {
        case .success:
            print("Получили Result в запросе removeCocktailFromFavorites")
            print("Коктейль успешно удален из избранного")
        case .failure(let error):
            print("Получили ошибку запроса removeCocktailFromFavorites:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func setCocktailRating(token: String, slug: String, rating: Int) async throws {
        
        let queryResult = await cocktailService.setCocktailRating(token: token, slug: slug, rating: rating)
        
        switch queryResult {
        case .success:
            print("Получили Result в запросе setCocktailRating")
            print("Рейтинг коктейля установлен")
        case .failure(let error):
            print("Получили ошибку запроса setCocktailRating:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func recipeSteps(token: String, ordering: String? = nil, name: Int? = nil) async throws {
        
        let queryResult = await cocktailService.recipeSteps(token: token, ordering: ordering, name: name)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе recipeSteps")
            stepsList = result
            print("Получили все шаги коктейля, шагов =", stepsList.count)
        case .failure(let error):
            print("Получили ошибку запроса recipeSteps:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
}



