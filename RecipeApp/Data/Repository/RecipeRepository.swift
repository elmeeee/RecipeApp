//
//  RecipeRepository.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//


import Foundation

protocol RecipeRepository {
    func fetchRecipes() async throws -> [Recipe]
}

protocol RecipeDataSource {
    func loadRecipes() async throws -> [Recipe]
}
