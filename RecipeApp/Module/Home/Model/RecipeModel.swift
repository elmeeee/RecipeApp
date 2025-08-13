//
//  RecipeModel.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//

import Foundation

struct Ingredient: Codable, Hashable {
    let name: String
    let quantity: String
}

struct Recipe: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let tags: [String]
    let minutes: Int
    let image: URL
    let ingredients: [Ingredient]
    let steps: [String]
}

enum SortOption: String, CaseIterable {
    case timeAsc = "Time ↑"
    case timeDesc = "Time ↓"
}

enum LoadingState {
    case idle, loading, loaded, empty, error(String)
}
