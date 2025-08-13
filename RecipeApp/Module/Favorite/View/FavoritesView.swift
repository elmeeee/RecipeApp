//
//  FavoritesView.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//


import SwiftUI
import UtilityKit

struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoritesStore
    let recipes: [Recipe]

    var body: some View {
        VStack() {
            let favs = recipes.filter { favorites.isFavorite($0.id) }
            if favs.isEmpty {
                EmptyStateView(title: "No favorites yet", subtitle: "Mark recipes with the heart to save them.")
            } else {
                List(favs) { r in
                    NavigationLink {
                        DetailView(vm: DetailViewModel(recipe: r))
                    } label: {
                        HStack(spacing: 12) {
                            CachedAsyncImage(url: r.image)
                                .frame(width: 80, height: 60).clipped().cornerRadius(8)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(r.title).font(.headline)
                                Text(r.tags.joined(separator: " • "))
                                    .font(.caption).foregroundStyle(.secondary)
                                Text("\(r.minutes) min").font(.caption2).foregroundStyle(.secondary)
                            }

                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Favorite")
    }
}
