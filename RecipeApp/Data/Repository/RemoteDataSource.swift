//
//  RemoteDataSource.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//


import Foundation
import NetworkingKit

struct RemoteDataSource: RecipeDataSource {
    let urlString: String

    func loadRecipes() async throws -> [Recipe] {
        guard let url = URL(string: urlString) else { throw AppError.invalidURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw AppError.networkFailed }
        do {
            return try JSONDecoder().decode([Recipe].self, from: data)
        } catch {
            throw AppError.decodeFailed
        }
    }
}
