//
//  IngredientService.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 21.05.23.
//

import Foundation

protocol IngredientsServiceable {
    func getAllIngredients(token: String?, page: Int?, limit: Int?, ordering: String?, strengthMin: Int?, strengthMax: Int?, tastes: [String]?, categories: [String]?, isInMyBar: Int?, isInShoppingList: Int?, name: String?, imgFormat: String?, imgSize: String?) async -> Result<IngredientModel, HTTPError>
    func fetchAllIngredientsShort(token: String?, page: Int?, limit: Int?, ordering: String?, strengthMin: Int?, strengthMax: Int?, tastes: [String]?, categories: [String]?, isInMyBar: Int?, isInShoppingList: Int?, name: String?, imgFormat: String?, imgSize: String?) async -> Result<IngredientModel, HTTPError>
    func getShoppingListOfIngredients(token: String, page: Int?, limit: Int?, imgFormat: String?, imgSize: String?) async -> Result<IngredientModel, HTTPError>
    func addIngredientToShoppingList(token: String, slug: String) async -> Result<AnyAnswerModel, HTTPError>
    func removeIngredientFromShoppingList(token: String, slug: String) async -> Result<AnyAnswerModel, HTTPError>
    func unitsOfMeasurement(token: String, ordering: String?, name: Int?) async -> Result<[Step], HTTPError>
    func addIngredienToBar(token: String, slug: String) async -> Result<AnyAnswerModel, HTTPError>
    func removeIngredientFromBar(token: String, slug: String) async -> Result<AnyAnswerModel, HTTPError>
    func fetchIngredientSlug(slug: String, imgFormat: String?, imgSize: String?) async -> Result<Ingredient, HTTPError>
    func fetchListOfIngredientCategories(page: Int?, limit: Int?, ordering: String?, name: String?) async -> Result<CategoryModel, HTTPError>
    func fetchIngredientCategorySlug(slug: String) async -> Result<Category, HTTPError>
}

class IngredientsService: HTTPClient, IngredientsServiceable {
    
    func getAllIngredients(token: String?, page: Int?, limit: Int?, ordering: String?, strengthMin: Int?, strengthMax: Int?, tastes: [String]?, categories: [String]?, isInMyBar: Int?, isInShoppingList: Int?, name: String?, imgFormat: String?, imgSize: String?) async -> Result<IngredientModel, HTTPError> {
            return await sendRequest(endpoint: IngredientEndpoint.fetchAllIngredients(token: token, page: page, limit: limit, ordering: ordering, strengthMin: strengthMin, strengthMax: strengthMax, tastes: tastes, categories: categories, isInMyBar: isInMyBar, isInShoppingList: isInShoppingList, name: name, imgFormat: imgFormat, imgSize: imgSize), responseModel: IngredientModel.self)
        }
    
    func fetchAllIngredientsShort(token: String?, page: Int?, limit: Int?, ordering: String?, strengthMin: Int?, strengthMax: Int?, tastes: [String]?, categories: [String]?, isInMyBar: Int?, isInShoppingList: Int?, name: String?, imgFormat: String?, imgSize: String?) async -> Result<IngredientModel, HTTPError> {
        return await sendRequest(endpoint: IngredientEndpoint.fetchAllIngredients(token: token, page: page, limit: limit, ordering: ordering, strengthMin: strengthMin, strengthMax: strengthMax, tastes: tastes, categories: categories, isInMyBar: isInMyBar, isInShoppingList: isInShoppingList, name: name, imgFormat: imgFormat, imgSize: imgSize), responseModel: IngredientModel.self)
    }
    
    
    func getShoppingListOfIngredients(token: String, page: Int?, limit: Int?, imgFormat: String?, imgSize: String?) async -> Result<IngredientModel, HTTPError> {
        return await sendRequest(endpoint: IngredientEndpoint.shoppingListOfIngredients(token: token, page: page, limit: limit, imgFormat: imgFormat, imgSize: imgSize), responseModel: IngredientModel.self)
    }
    
    func addIngredientToShoppingList(token: String, slug: String) async -> Result<AnyAnswerModel, HTTPError> {
        return await sendRequest(endpoint: IngredientEndpoint.addIngredientToShoppingList(token: token, slug: slug), responseModel: AnyAnswerModel.self)
    }
    
    func removeIngredientFromShoppingList(token: String, slug: String) async -> Result<AnyAnswerModel, HTTPError> {
        return await sendRequest(endpoint: IngredientEndpoint.removeIngredientFromShoppingList(token: token, slug: slug), responseModel: AnyAnswerModel.self)
    }
    
    func unitsOfMeasurement(token: String, ordering: String?, name: Int?) async -> Result<[Step], HTTPError> {
        return await sendRequest(endpoint: IngredientEndpoint.unitsOfMeasurement(token: token, ordering: ordering, name: name), responseModel: [Step].self)
    }
    
    func addIngredienToBar(token: String, slug: String) async -> Result<AnyAnswerModel, HTTPError> {
        return await sendRequest(endpoint: IngredientEndpoint.addIngredienToBar(token: token, slug: slug), responseModel: AnyAnswerModel.self)
    }
    
    func removeIngredientFromBar(token: String, slug: String) async -> Result<AnyAnswerModel, HTTPError> {
        return await sendRequest(endpoint: IngredientEndpoint.removeIngredientFromBar(token: token, slug: slug), responseModel: AnyAnswerModel.self)
    }
    
    func fetchIngredientSlug(slug: String, imgFormat: String?, imgSize: String?) async -> Result<Ingredient, HTTPError> {
        return await sendRequest(endpoint: IngredientEndpoint.fetchIngredientSlug(slug: slug, imgFormat: imgFormat, imgSize: imgSize), responseModel: Ingredient.self)
    }
    
    func fetchListOfIngredientCategories(page: Int?, limit: Int?, ordering: String?, name: String?) async -> Result<CategoryModel, HTTPError> {
        return await sendRequest(endpoint: IngredientEndpoint.fetchListOfIngredientCategories(page: page, limit: limit, ordering: ordering, name: name), responseModel: CategoryModel.self)
    }
    
    func fetchIngredientCategorySlug(slug: String) async -> Result<Category, HTTPError> {
        return await sendRequest(endpoint: IngredientEndpoint.fetchIngredientCategorySlug(slug: slug), responseModel: Category.self)
    }
    
}
