//
//  IngredientAggregateModel.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 21.05.23.
//

import Foundation

@MainActor
class IngredientAggregateModel: ObservableObject {
    
    let ingredientService: IngredientsService
    
    @Published var ingredientList: [Ingredient] = []
    @Published var ingredientShopingList: [Ingredient] = []
    @Published var ingredient: Ingredient?
    @Published var measurementList: [Step] = []
    @Published var ingredientCategoryList: [Category] = []
    @Published var ingredientCategory: Category?
    @Published var ingredientsCount: Int?
    @Published var ingredientsNextPage: Int?
    
    init(ingredientService: IngredientsService) {
        self.ingredientService = ingredientService
    }
    
    func getIngredientList(token: String? = nil, page: Int? = nil, limit: Int? = nil, ordering: String? = nil, strengthMin: Int? = nil, strengthMax: Int? = nil, tastes: [String]? = nil, categories: [String]? = nil, isInMyBar: Int? = nil, isInShoppingList: Int? = nil, name: String? = nil, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await ingredientService.getAllIngredients(token: token, page: page, limit: limit, ordering: ordering, strengthMin: strengthMin, strengthMax: strengthMax, tastes: tastes, categories: categories, isInMyBar: isInMyBar, isInShoppingList: isInShoppingList, name: name, imgFormat: imgFormat, imgSize: imgSize)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе getIngredientList")
            ingredientList = result.results ?? []
            ingredientsCount = result.count
            if let nextPageURL = result.next {
                let pattern = "page=(\\d+)"
                if let regex = try? NSRegularExpression(pattern: pattern),
                   let match = regex.firstMatch(in: nextPageURL, options: [], range: NSRange(location: 0, length: nextPageURL.utf16.count)),
                   let range = Range(match.range(at: 1), in: nextPageURL) {
                    ingredientsNextPage = Int(nextPageURL[range])
                } else {
                    ingredientsNextPage = nil
                }
            } else {
                ingredientsNextPage = nil
            }
            print("Следующая страница =", ingredientsNextPage ?? "Ничего нет в следующем номере страницы")
            print("Кол-во ингредиентов", ingredientList.count)
        case .failure(let error):
            print("Получили ошибку запроса getIngredientList:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func getNextPageOfIngredientList(token: String? = nil, page: Int? = nil, limit: Int? = nil, ordering: String? = nil, strengthMin: Int? = nil, strengthMax: Int? = nil, tastes: [String]? = nil, categories: [String]? = nil, isInMyBar: Int? = nil, isInShoppingList: Int? = nil, name: String? = nil, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await ingredientService.getAllIngredients(token: token, page: page, limit: limit, ordering: ordering, strengthMin: strengthMin, strengthMax: strengthMax, tastes: tastes, categories: categories, isInMyBar: isInMyBar, isInShoppingList: isInShoppingList, name: name, imgFormat: imgFormat, imgSize: imgSize)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе getNextPageOfIngredientList")
            ingredientsCount = result.count
            if let nextPageURL = result.next {
                let pattern = "page=(\\d+)"
                if let regex = try? NSRegularExpression(pattern: pattern),
                   let match = regex.firstMatch(in: nextPageURL, options: [], range: NSRange(location: 0, length: nextPageURL.utf16.count)),
                   let range = Range(match.range(at: 1), in: nextPageURL) {
                    ingredientsNextPage = Int(nextPageURL[range])
                } else {
                    ingredientsNextPage = nil
                }
            } else {
                ingredientsNextPage = nil
            }
            ingredientList.append(contentsOf: result.results ?? [])
            print("Следующая страница =", ingredientsNextPage ?? "Ничего нет в следующем номере страницы")
            print("Кол-во ингредиентов", ingredientList.count)
        case .failure(let error):
            print("Получили ошибку запроса getNextPageOfIngredientList:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    
    func fetchAllIngredientsShort(token: String? = nil, page: Int? = nil, limit: Int? = nil, ordering: String? = nil, strengthMin: Int? = nil, strengthMax: Int? = nil, tastes: [String]? = nil, categories: [String]? = nil, isInMyBar: Int? = nil, isInShoppingList: Int? = nil, name: String? = nil, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await ingredientService.fetchAllIngredientsShort(token: token, page: page, limit: limit, ordering: ordering, strengthMin: strengthMin, strengthMax: strengthMax, tastes: tastes, categories: categories, isInMyBar: isInMyBar, isInShoppingList: isInShoppingList, name: name, imgFormat: imgFormat, imgSize: imgSize)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе fetchAllIngredientsShort")
            ingredientList = result.results ?? []
            print("Кол-во ингредиентов", ingredientList.count)
        case .failure(let error):
            print("Получили ошибку запроса fetchAllIngredientsShort:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func getShoppingListOfIngredients(token: String, page: Int? = nil, limit: Int? = nil, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await ingredientService.getShoppingListOfIngredients(token: token, page: page, limit: limit, imgFormat: imgFormat, imgSize: imgSize)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе getShoppingListOfIngredients")
            ingredientShopingList = result.results ?? []
            print("Кол-во ингредиентов в списке покупок", ingredientShopingList.count)
        case .failure(let error):
            print("Получили ошибку запроса getShoppingListOfIngredients:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func addIngredientToShoppingList(token: String, slug: String) async throws {
        
        let queryResult = await ingredientService.addIngredientToShoppingList(token: token, slug: slug)
        
        switch queryResult {
        case .success:
            print("Получили Result в запросе addIngredientToShoppingList")
            print("Ингредиент добавлен в список покупок")
        case .failure(let error):
            print("Получили ошибку запроса addIngredientToShoppingList:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func removeIngredientFromShoppingList(token: String, slug: String) async throws {
        
        let queryResult = await ingredientService.removeIngredientFromShoppingList(token: token, slug: slug)
        
        switch queryResult {
        case .success:
            print("Получили Result в запросе removeIngredientFromShoppingList")
            print("Ингредиент удален из списка покупок")
        case .failure(let error):
            print("Получили ошибку запроса removeIngredientFromShoppingList:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func unitsOfMeasurement(token: String, ordering: String? = nil, name: Int? = nil) async throws {
        
        let queryResult = await ingredientService.unitsOfMeasurement(token: token, ordering: ordering, name: name)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе unitsOfMeasurement")
            measurementList = result
            print("Получили все виды измерений, измерения =", measurementList.count)
        case .failure(let error):
            print("Получили ошибку запроса unitsOfMeasurement:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func addIngredienToBar(token: String, slug: String) async throws {
        
        let queryResult = await ingredientService.addIngredienToBar(token: token, slug: slug)
        
        switch queryResult {
        case .success:
            print("Получили Result в запросе addIngredienToBar")
            print("Ингредиент успешно добавлен в бар")
        case .failure(let error):
            print("Получили ошибку запроса addIngredienToBar:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func removeIngredientFromBar(token: String, slug: String) async throws {
        
        let queryResult = await ingredientService.removeIngredientFromBar(token: token, slug: slug)
        
        switch queryResult {
        case .success:
            print("Получили Result в запросе removeIngredientFromBar")
            print("Ингредиент успешно удален из бара")
        case .failure(let error):
            print("Получили ошибку запроса removeIngredientFromBar:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func fetchIngredientSlug(slug: String, imgFormat: String? = nil, imgSize: String? = nil) async throws {
        
        let queryResult = await ingredientService.fetchIngredientSlug(slug: slug, imgFormat: imgFormat, imgSize: imgSize)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе fetchIngredientSlug")
            ingredient = result
            print("Название ингредиента =", ingredient?.name ?? "Нет там ничего по слагу")
        case .failure(let error):
            print("Получили ошибку запроса fetchIngredientSlug:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func fetchListOfIngredientCategories(page: Int? = nil, limit: Int? = nil, ordering: String? = nil, name: String? = nil) async throws {
        
        let queryResult = await ingredientService.fetchListOfIngredientCategories(page: page, limit: limit, ordering: ordering, name: name)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе fetchListOfIngredientCategories")
            ingredientCategoryList = result.results ?? []
            print("Кол-во категорий в ингредиентах =", ingredientCategoryList.count)
        case .failure(let error):
            print("Получили ошибку запроса fetchListOfIngredientCategories:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }
    
    func fetchIngredientCategorySlug(slug: String) async throws {
        
        let queryResult = await ingredientService.fetchIngredientCategorySlug(slug: slug)
        
        switch queryResult {
        case .success(let result):
            print("Получили Result в запросе fetchIngredientCategorySlug")
            ingredientCategory = result
            print("Название категории по слагу =", ingredientCategory?.name ?? "Нет там ничего по слагу")
        case .failure(let error):
            print("Получили ошибку запроса fetchIngredientCategorySlug:", error.localizedDescription)
            print("Описание ошибки:", error.errorDescription ?? "Описание ошибки отсутствует")
            throw error
        }
    }

    
}

