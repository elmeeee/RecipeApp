//
//  Logger.swift
//  ModuleKit
//
//  Created by Elmee on 13/08/25.
//

import Foundation

public enum AppEvent: String {
    case appLaunch
    case recipeViewed
    case recipeFavorited
    case recipeUnfavorited
    case mealPlanAdded
}

public struct Logger {
    public static func log(_ event: AppEvent, metadata: [String: Any]? = nil) {
        let ts = ISO8601DateFormatter().string(from: Date())
        var logMsg = "[\(ts)] EVENT: \(event.rawValue)"
        if let metadata = metadata {
            let metaString = metadata.map { "\($0): \($1)" }.joined(separator: ", ")
            logMsg += " { \(metaString) }"
        }
        print(logMsg)
    }
}
