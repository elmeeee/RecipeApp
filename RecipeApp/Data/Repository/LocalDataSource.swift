//
//  LocalDataSource.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//


import Foundation
import NetworkingKit

struct LocalDataSource: RecipeDataSource {
    let fileName: String = "recipes"
    let fileExt: String = "json"

    func loadRecipes() async throws -> [Recipe] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExt) else {
            throw AppError.fileNotFound
        }
        let data = try Data(contentsOf: url)
        do {
            return try JSONDecoder().decode([Recipe].self, from: data)
        } catch {
            throw AppError.decodeFailed
        }
    }
}
