//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//

import SwiftUI
import NetworkingKit
import AnalyticsKit

@main
struct RecipeAppApp: App {
    @StateObject private var favorites = FavoritesStore()
    @StateObject private var mealPlan = MealPlanStore()
    private let repo = CombinedRepository()

    init() {
        URLCacheConfig.setup()
        Logger.log(.appLaunch)
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView(vm: HomeViewModel(repo: repo, favorites: favorites))
                    .environmentObject(favorites)
                    .environmentObject(mealPlan)
                    .tabItem { Label("Browse", systemImage: "list.bullet") }

                NavigationStack {
                    FavoritesContainerView(repo: repo)
                }
                .environmentObject(favorites)
                .tabItem { Label("Favorites", systemImage: "heart") }

                NavigationStack {
                    MealPlanContainerView(repo: repo)
                }
                .environmentObject(mealPlan)
                .tabItem { Label("Plan", systemImage: "calendar") }
            }
            .withGlobalSnackbar()
        }
    }
}
