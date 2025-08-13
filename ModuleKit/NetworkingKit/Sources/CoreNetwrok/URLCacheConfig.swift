//
//  URLCacheConfig.swift
//  ModuleKit
//
//  Created by Elmee on 13/08/25.
//


import Foundation

public enum URLCacheConfig {
    public static func setup() {
        let mem = 50 * 1024 * 1024
        let disk = 200 * 1024 * 1024
        URLCache.shared = URLCache(memoryCapacity: mem, diskCapacity: disk)
    }
}
