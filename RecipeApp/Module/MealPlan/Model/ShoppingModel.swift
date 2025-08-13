//
//  ShoppingModel.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//

import Foundation

struct ShoppingLine: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let quantity: String
}

enum Unit: String { case g, pcs, tbsp, cup, pc, unknown }

private func parseQuantity(_ text: String) -> (Double, Unit)? {
    let parts = text.lowercased().split(separator: " ")
    guard parts.count >= 2, let value = Double(parts[0]) else { return nil }
    let unit = Unit(rawValue: String(parts[1])) ?? .unknown
    return (value, unit)
}

func consolidate(ingredients: [Ingredient]) -> [ShoppingLine] {
    var bucket: [String: (Double, Unit, [String])] = [:]
    for ing in ingredients {
        if let (val, unit) = parseQuantity(ing.quantity), unit == .g || unit == .pcs || unit == .pc {
            let key = ing.name.lowercased()
            var current = bucket[key] ?? (0, unit, [])
            current.0 += val
            current.1 = unit
            bucket[key] = current
        } else {
            let key = ing.name.lowercased()
            var current = bucket[key] ?? (0, .unknown, [])
            current.2.append(ing.quantity)
            bucket[key] = current
        }
    }

    var lines: [ShoppingLine] = []
    for (name, entry) in bucket {
        if entry.1 == .g { lines.append(.init(name: name.capitalized, quantity: "\(Int(entry.0)) g")) }
        else if entry.1 == .pcs || entry.1 == .pc { lines.append(.init(name: name.capitalized, quantity: "\(Int(entry.0)) pcs")) }
        else {
            let joined = entry.2.joined(separator: " + ")
            lines.append(.init(name: name.capitalized, quantity: joined.isEmpty ? "—" : joined))
        }
    }
    return lines.sorted { $0.name < $1.name }
}
