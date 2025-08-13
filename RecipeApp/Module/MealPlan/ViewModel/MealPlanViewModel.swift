//
//  MealPlanViewModel.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.


import Foundation

@MainActor
final class MealPlanViewModel: ObservableObject {
    @Published var shopping: [ShoppingLine] = []

    func buildShoppingList(plan: [Weekday: [String]], recipes: [Recipe]) {
        var selected: [Ingredient] = []
        for (_, ids) in plan {
            for id in ids {
                if let r = recipes.first(where: { $0.id == id }) {
                    selected.append(contentsOf: r.ingredients)
                }
            }
        }
        shopping = consolidate(ingredients: selected)
    }
}
