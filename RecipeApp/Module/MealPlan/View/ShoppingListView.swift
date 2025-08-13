//
//  ShoppingListView.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//


import SwiftUI
import UIKit
import UtilityKit

struct ShoppingListView: View {
    @EnvironmentObject var mealPlan: MealPlanStore
    @StateObject var vm = MealPlanViewModel()
    let recipes: [Recipe]
    @State private var sharePresented = false

    var body: some View {
        VStack {
            if vm.shopping.isEmpty {
                EmptyStateView(title: "No items", subtitle: "Add recipes to your plan to generate a shopping list.")
            } else {
                List(vm.shopping) { line in
                    HStack {
                        Text(line.name)
                        Spacer()
                        Text(line.quantity).foregroundStyle(.secondary)
                    }
                }.listStyle(.plain)
            }
        }
        .navigationTitle("Shopping List")
        .toolbar {
            Button {
                sharePresented = true
            } label: {
                Image(systemName: "square.and.arrow.up")
            }.disabled(vm.shopping.isEmpty)
        }
        .onAppear { vm.buildShoppingList(plan: mealPlan.plan, recipes: recipes) }
        .sheet(isPresented: $sharePresented) {
            let text = vm.shopping.map { "• \($0.name): \($0.quantity)" }.joined(separator: "\n")
            ActivityViewController(activityItems: [text])
        }
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
