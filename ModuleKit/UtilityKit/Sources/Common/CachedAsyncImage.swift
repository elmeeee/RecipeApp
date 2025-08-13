//
//  CachedAsyncImage.swift
//  ModuleKit
//
//  Created by Elmee on 13/08/25.
//


import SwiftUI

public struct CachedAsyncImage: View {
    
    public init(url: URL) {
        self.url = url
    }
    
    let url: URL

    public var body: some View {
        AsyncImage(url: url, transaction: Transaction(animation: .easeInOut)) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Rectangle().fill(.gray.opacity(0.15))
                    ProgressView()
                }
            case .success(let image):
                image.resizable().scaledToFill()
            case .failure:
                ZStack {
                    Rectangle().fill(.gray.opacity(0.2))
                    Image(systemName: "photo").imageScale(.large)
                }
            @unknown default:
                Color.clear
            }
        }
    }
}
