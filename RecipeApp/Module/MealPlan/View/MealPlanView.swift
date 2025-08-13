//
//  MealPlanView.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//


import SwiftUI

struct MealPlanView: View {
    @EnvironmentObject var mealPlan: MealPlanStore
    let recipes: [Recipe]

    var body: some View {
        List {
            ForEach(Weekday.allCases) { day in
                Section(day.label) {
                    let ids = mealPlan.plan[day] ?? []
                    if ids.isEmpty {
                        Text("No recipes yet").foregroundStyle(.secondary)
                    } else {
                        ForEach(ids, id: \.self) { id in
                            if let r = recipes.first(where: { $0.id == id }) {
                                HStack {
                                    Text(r.title)
                                    Spacer()
                                    Button(role: .destructive) { mealPlan.remove(id, from: day) } label: {
                                        Image(systemName: "trash")
                                    }.buttonStyle(.borderless)
                                }
                            }
                        }
                        Button("Clear \(day.label)") {
                            mealPlan.clearDay(day)
                        }.foregroundStyle(.red)
                    }
                }
            }
        }.navigationTitle("This Week’s Plan")
    }
}
