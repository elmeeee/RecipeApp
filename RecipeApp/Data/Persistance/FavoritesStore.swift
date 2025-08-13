//
//  FavoritesStore.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//


import Foundation

@MainActor
final class FavoritesStore: ObservableObject {
    @Published private(set) var ids: Set<String> = []
    private let key = "favorite_ids"

    init() { load() }

    func toggle(_ id: String) {
        if ids.contains(id) { ids.remove(id) } else { ids.insert(id) }
        save()
    }

    func isFavorite(_ id: String) -> Bool { ids.contains(id) }

    private func load() {
        if let arr = UserDefaults.standard.array(forKey: key) as? [String] {
            ids = Set(arr)
        }
    }

    private func save() {
        UserDefaults.standard.set(Array(ids), forKey: key)
    }
}