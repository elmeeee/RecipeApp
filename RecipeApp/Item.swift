//
//  Item.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
