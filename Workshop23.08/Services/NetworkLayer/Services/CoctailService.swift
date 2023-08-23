//
//  CoctailService.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 14.05.23.
//

import Foundation

protocol CoctailsServiceable {
    func getAllCoctails(token: String?, page: Int?, limit: Int?, ordering: String?, author: Int?, strengths: [String]?, tastes: [String]?, complexities: [String]?, formats: [String]?, ingredients: [String]?, isFavorited: Int?, name: String?, imgFormat: String?, imgSize: String?) async -> Result<CocktailModel, HTTPError>
    func cocktailRecommendationsList(token: String, page: Int?, limit: Int?, imgFormat: String?, imgSize: String?) async -> Result<CocktailRecommendationModel, HTTPError>
    func fetchCocktailSlug(slug: String, imgFormat: String?, imgSize: String?) async -> Result<Cocktail, HTTPError>
    func addCocktailToFavorites(token: String, slug: String) async -> Result<AnyAnswerModel, HTTPError>
    func removeCocktailFromFavorites(token: String, slug: String) async -> Result<AnyAnswerModel, HTTPError>
    func setCocktailRating(token: String, slug: String, rating: Int) async -> Result<AnyAnswerModel, HTTPError>
    func recipeSteps(token: String, ordering: String?, name: Int?) async -> Result<[Step], HTTPError>
}

class CoctailsService: HTTPClient, CoctailsServiceable {

    func getAllCoctails(token: String?, page: Int?, limit: Int?, ordering: String?, author: Int?, strengths: [String]?, tastes: [String]?, complexities: [String]?, formats: [String]?, ingredients: [String]?, isFavorited: Int?, name: String?, imgFormat: String?, imgSize: String?) async -> Result<CocktailModel, HTTPError> {
        return await sendRequest(endpoint: CocktailEndpoint.fetchAllCocktails(token: token, page: page, limit: limit, ordering: ordering, author: author, strengths: strengths, tastes: tastes, complexities: complexities, formats: formats, ingredients: ingredients, isFavorited: isFavorited, name: name, imgFormat: imgFormat, imgSize: imgSize), responseModel: CocktailModel.self)
    }
    
    func cocktailRecommendationsList(token: String, page: Int?, limit: Int?, imgFormat: String?, imgSize: String?) async -> Result<CocktailRecommendationModel, HTTPError> {
        return await sendRequest(endpoint: BarEndpoint.cocktailRecommendationsList(token: token, page: page, limit: limit, imgFormat: imgFormat, imgSize: imgSize), responseModel: CocktailRecommendationModel.self)
    }
    
    func fetchCocktailSlug(slug: String, imgFormat: String?, imgSize: String?) async -> Result<Cocktail, HTTPError> {
        return await sendRequest(endpoint: CocktailEndpoint.fetchCocktailSlug(slug: slug, imgFormat: imgFormat, imgSize: imgSize), responseModel: Cocktail.self)
    }
    
    func addCocktailToFavorites(token: String, slug: String) async -> Result<AnyAnswerModel, HTTPError> {
        return await sendRequest(endpoint: CocktailEndpoint.addCocktailToFavorites(token: token, slug: slug), responseModel: AnyAnswerModel.self)
    }
    
    func removeCocktailFromFavorites(token: String, slug: String) async -> Result<AnyAnswerModel, HTTPError> {
        return await sendRequest(endpoint: CocktailEndpoint.removeCocktailFromFavorites(token: token, slug: slug), responseModel: AnyAnswerModel.self)
    }
    
    func setCocktailRating(token: String, slug: String, rating: Int) async -> Result<AnyAnswerModel, HTTPError> {
        return await sendRequest(endpoint: CocktailEndpoint.setCocktailRating(token: token, slug: slug, rating: rating), responseModel: AnyAnswerModel.self)
    }
    
    func recipeSteps(token: String, ordering: String?, name: Int?) async -> Result<[Step], HTTPError> {
        return await sendRequest(endpoint: CocktailEndpoint.recipeSteps(token: token, ordering: ordering, name: name), responseModel: [Step].self)
    }
    
}
