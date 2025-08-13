//
//  TagChipsView.swift
//  ModuleKit
//
//  Created by Elmee on 13/08/25.
//


import SwiftUI

public struct TagChipsView: View {
    public init(tags: [String], selected: Binding<Set<String>>) {
        self.tags = tags
        self._selected = selected
    }

    
    let tags: [String]
    @Binding var selected: Set<String>

    public var body: some View {
        HStack(spacing: 8) {
            ForEach(tags, id: \.self) { tag in
                let isOn = selected.contains(tag)
                Text(tag.capitalized)
                    .padding(.horizontal, 12).padding(.vertical, 6)
                    .background(isOn ? Color.secondaryBlue900.opacity(0.2) : Color.gray.opacity(0.12))
                    .foregroundStyle(isOn ? .fontBlack : Color.gray)
                    .clipShape(Capsule())
                    .onTapGesture {
                        if isOn { selected.remove(tag) } else { selected.insert(tag) }
                    }
                    .accessibilityLabel("\(tag), \(isOn ? "selected" : "not selected")")
            }
        }
    }
}
