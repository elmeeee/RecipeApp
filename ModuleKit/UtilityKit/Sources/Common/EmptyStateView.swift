//
//  EmptyStateView.swift
//  ModuleKit
//
//  Created by Elmee on 13/08/25.
//


import SwiftUI

public struct EmptyStateView: View {
    public init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    let title: String
    let subtitle: String
    
    public  var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "fork.knife.circle")
                .font(.system(size: 48))
            Text(title).font(.title3).bold()
            Text(subtitle).font(.subheadline).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .padding(24)
    }
}
