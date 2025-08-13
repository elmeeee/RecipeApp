//
//  HomeViewModel.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//


import Foundation
import AnalyticsKit

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var state: LoadingState = .idle
    @Published var all: [Recipe] = []
    @Published var filtered: [Recipe] = []
    @Published var searchText: String = ""
    @Published var sort: SortOption = .timeAsc
    @Published var selectedTags: Set<String> = []
    @Published var uniqueTags: [String] = []
    @Published var useRemote = false
    @Published var remoteURLText = "https://raw.githubusercontent.com/elmeeee/RecipeApp/refs/heads/main/RecipeApp/Data/recipes.json?token=GHSAT0AAAAAADC6WWIGOJM3HGXRZL25O2WO2E4WOVQ"

    private let repo: CombinedRepository
    private let favorites: FavoritesStore

    init(repo: CombinedRepository, favorites: FavoritesStore) {
        self.repo = repo
        self.favorites = favorites
    }

    func setSourceLocal() { repo.setSource(.local) }
    func setSourceRemote(_ url: String) { repo.setSource(.remote(url)) }

    @discardableResult
    func load() async -> Bool {
        state = .loading
        do {
            let items = try await repo.fetchRecipes()
            self.all = items
            self.uniqueTags = Array(Set(items.flatMap { $0.tags })).sorted()
            applyFilters()
            state = filtered.isEmpty ? .empty : .loaded
            return true
        } catch {
            state = .error((error as? LocalizedError)?.errorDescription ?? "Unknown error")
            if case .remote(_) = repo.currentSource {
                setSourceLocal()
                try? await Task.sleep(nanoseconds: 500_000_000)
                _ = await load()
            }
            return false
        }
    }

    func onSearchTextChanged() {
        Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            await MainActor.run { self.applyFilters() }
        }
    }

    func applyFilters() {
        var items = all

        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if !q.isEmpty {
            items = items.filter { r in
                let inTitle = r.title.lowercased().contains(q)
                let inIng = r.ingredients.contains { $0.name.lowercased().contains(q) }
                return inTitle || inIng
            }
        }

        if !selectedTags.isEmpty {
            items = items.filter { !Set($0.tags).isDisjoint(with: selectedTags) }
        }

        switch sort {
        case .timeAsc:  items.sort { $0.minutes < $1.minutes }
        case .timeDesc: items.sort { $0.minutes > $1.minutes }
        }

        self.filtered = items
        if items.isEmpty {
            if case .loaded = state { state = .empty }
        } else {
            state = .loaded
        }
    }

    func isFavorite(_ id: String) -> Bool { favorites.isFavorite(id) }
    
    @discardableResult
    func toggleFavorite(_ id: String) -> Bool {
        favorites.toggle(id)
        let nowFav = favorites.isFavorite(id)
        Logger.log(nowFav ? .recipeFavorited : .recipeUnfavorited, metadata: ["recipeId": id])
        return nowFav
    }
}
