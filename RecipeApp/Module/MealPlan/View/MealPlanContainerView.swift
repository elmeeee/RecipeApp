//
//  MealPlanContainerView.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//

import SwiftUI

struct MealPlanContainerView: View {
    let repo: CombinedRepository
    @EnvironmentObject var mealPlan: MealPlanStore
    @State private var recipes: [Recipe] = []
    
    var body: some View {
        List {
            NavigationLink("This Week’s Plan") { MealPlanView(recipes: recipes) }
            NavigationLink("Shopping List") { ShoppingListView(recipes: recipes) }
        }
        .navigationTitle("Plan")
        .task {
            do { recipes = try await repo.fetchRecipes() } catch {}
        }
    }
}
