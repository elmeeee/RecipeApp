//
//  DetailViewModel.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//


import Foundation

@MainActor
final class DetailViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var checked: Set<String> = []

    init(recipe: Recipe) { self.recipe = recipe }

    func toggleCheck(_ name: String) {
        if checked.contains(name) { checked.remove(name) } else { checked.insert(name) }
    }

    func isChecked(_ name: String) -> Bool { checked.contains(name) }
}