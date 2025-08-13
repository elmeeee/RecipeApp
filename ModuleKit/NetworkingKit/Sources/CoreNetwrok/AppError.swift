//
//  AppError.swift
//  ModuleKit
//
//  Created by Elmee on 13/08/25.
//


import Foundation

public enum AppError: Error, LocalizedError {
    case fileNotFound
    case decodeFailed
    case networkFailed
    case invalidURL

    public var errorDescription: String? {
        switch self {
        case .fileNotFound: return "Data file not found."
        case .decodeFailed: return "Failed to decode data."
        case .networkFailed: return "Network request failed."
        case .invalidURL: return "Invalid remote data URL."
        }
    }
}
