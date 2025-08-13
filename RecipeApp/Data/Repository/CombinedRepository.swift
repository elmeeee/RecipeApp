//
//  CombinedRepository.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//


import Foundation

@MainActor
final class CombinedRepository: RecipeRepository {
    enum Source {
        case local
        case remote(String)
    }

    private let local = LocalDataSource()
    private var currentSource: Source = .local

    func setSource(_ source: Source) { currentSource = source }

    func fetchRecipes() async throws -> [Recipe] {
        do {
            switch currentSource {
            case .local:
                return try await local.loadRecipes()
            case .remote(let url):
                let remote = RemoteDataSource(urlString: url)
                return try await remote.loadRecipes()
            }
        } catch {
            do { return try await local.loadRecipes() }
            catch { throw error }
        }
    }
}
