//
//  MealPlanStore.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//

import Foundation
import AnalyticsKit

enum Weekday: String, CaseIterable, Identifiable {
    case mon, tue, wed, thu, fri, sat, sun
    var id: String { rawValue }
    var label: String {
        switch self {
        case .mon: return "Mon"
        case .tue: return "Tue"
        case .wed: return "Wed"
        case .thu: return "Thu"
        case .fri: return "Fri"
        case .sat: return "Sat"
        case .sun: return "Sun"
        }
    }
}

@MainActor
final class MealPlanStore: ObservableObject {
    private let key = "meal_plan"
    @Published private(set) var plan: [Weekday: [String]] = [:]

    init() { load() }

    func add(_ recipeId: String, to day: Weekday) {
        var list = plan[day, default: []]
        if !list.contains(recipeId) {
            list.append(recipeId)
            plan[day] = list
            Logger.log(.mealPlanAdded, metadata: ["recipeId": recipeId, "day": day.label])
        }
        save()
    }

    func remove(_ recipeId: String, from day: Weekday) {
        plan[day]?.removeAll { $0 == recipeId }
        save()
    }

    func clearDay(_ day: Weekday) {
        plan[day] = []
        save()
    }

    private func save() {
        let dict = Dictionary(uniqueKeysWithValues: plan.map { ($0.key.rawValue, $0.value) })
        UserDefaults.standard.set(dict, forKey: key)
    }

    private func load() {
        guard let dict = UserDefaults.standard.dictionary(forKey: key) as? [String: [String]] else { return }
        var result: [Weekday: [String]] = [:]
        for (k, v) in dict {
            if let d = Weekday(rawValue: k) { result[d] = v }
        }
        self.plan = result
    }
}
