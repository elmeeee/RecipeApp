//
//  FavoritesContainerView.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//
import SwiftUI

struct FavoritesContainerView: View {
    let repo: CombinedRepository
    @State private var recipes: [Recipe] = []
    
    var body: some View {
        FavoritesView(recipes: recipes)
            .task {
                do { recipes = try await repo.fetchRecipes() } catch {}
            }
    }
}
