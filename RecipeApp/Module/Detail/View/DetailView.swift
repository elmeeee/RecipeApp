//
//  DetailView.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//


import SwiftUI
import UtilityKit

struct DetailView: View {
    @EnvironmentObject var favorites: FavoritesStore
    @EnvironmentObject var mealPlan: MealPlanStore
    @EnvironmentObject var snackbar: SnackbarManager
    @StateObject var vm: DetailViewModel
    @State private var addDay: Weekday = .mon

    var body: some View {
        ScrollView {
            CachedAsyncImage(url: vm.recipe.image)
                .frame(height: 220).clipped()

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(vm.recipe.title).font(.title2).bold()
                    Spacer()
                    Button {
                        favorites.toggle(vm.recipe.id)
                        if favorites.isFavorite(vm.recipe.id) {
                            snackbar.show("Added to Favorites", style: .success)
                        } else {
                            snackbar.show("Removed from Favorites", style: .info)
                        }
                    } label: {
                        Image(systemName: favorites.isFavorite(vm.recipe.id) ? "heart.fill" : "heart")
                            .font(.title3)
                    }
                    .accessibilityLabel("Toggle favorite")
                }

                Text("Tags: \(vm.recipe.tags.joined(separator: ", "))")
                    .font(.subheadline).foregroundStyle(.secondary)

                Text("Ingredients").font(.headline)
                ForEach(vm.recipe.ingredients, id: \.self) { ing in
                    HStack {
                        Image(systemName: vm.isChecked(ing.name) ? "checkmark.circle.fill" : "circle")
                            .onTapGesture { vm.toggleCheck(ing.name) }
                        Text(ing.name)
                        Spacer()
                        Text(ing.quantity).foregroundStyle(.secondary)
                    }
                }

                Text("Method").font(.headline)
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(Array(vm.recipe.steps.enumerated()), id: \.offset) { idx, step in
                        HStack(alignment: .top) {
                            Text("\(idx+1).").bold()
                            Text(step)
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Add to This Week’s Plan").font(.headline)
                    HStack {
                        Picker("Day", selection: $addDay) {
                            ForEach(Weekday.allCases) { Text($0.label).tag($0) }
                        }.pickerStyle(.segmented)
                        Button("Add") {
                            mealPlan.add(vm.recipe.id, to: addDay)
                            snackbar.show("Added to \(addDay.label) plan", style: .success)
                        }
                            .buttonStyle(.borderedProminent)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
