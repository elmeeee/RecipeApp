//
//  Snackbar.swift
//  ModuleKit
//
//  Created by Elmee on 13/08/25.
//

import SwiftUI

public enum SnackbarStyle {
    case success, error, info

    var bg: Color {
        switch self {
        case .success: return Color.primaryGreen100.opacity(0.92)
        case .error:   return Color.secondaryRed100.opacity(0.92)
        case .info:    return Color.secondaryBlue100.opacity(0.92)
        }
    }
    var fg: Color { .white }
    var icon: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error:   return "xmark.octagon.fill"
        case .info:    return "info.circle.fill"
        }
    }
}

public struct SnackbarItem: Identifiable, Equatable {
    public let id = UUID()
    public let message: String
    public let style: SnackbarStyle
    public let duration: TimeInterval
    public init(_ message: String, style: SnackbarStyle = .info, duration: TimeInterval = 2.0) {
        self.message = message
        self.style = style
        self.duration = duration
    }
}

@MainActor
public final class SnackbarManager: ObservableObject {
    @Published public private(set) var current: SnackbarItem? = nil
    private var queue: [SnackbarItem] = []
    private var dismissTask: Task<Void, Never>?

    public init() {}

    public func show(_ message: String, style: SnackbarStyle = .info, duration: TimeInterval = 2.0) {
        enqueue(SnackbarItem(message, style: style, duration: duration))
    }

    public func enqueue(_ item: SnackbarItem) {
        queue.append(item)
        presentNextIfNeeded()
    }

    private func presentNextIfNeeded() {
        guard current == nil, !queue.isEmpty else { return }
        current = queue.removeFirst()

        dismissTask?.cancel()
        dismissTask = Task { [weak self] in
            guard let self else { return }
            let ns = UInt64((self.current?.duration ?? 2.0) * 1_000_000_000)
            try? await Task.sleep(nanoseconds: ns)
            await MainActor.run { self.dismiss() }
        }
    }

    public func dismiss() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
            current = nil
        }
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 200_000_000)
            presentNextIfNeeded()
        }
    }
}

public struct SnackbarHostView: View {
    @ObservedObject var manager: SnackbarManager
    public init(manager: SnackbarManager) { self.manager = manager }

    public var body: some View {
        VStack {
            Spacer()
            if let item = manager.current {
                HStack(spacing: 12) {
                    Image(systemName: item.style.icon)
                        .imageScale(.large)
                    Text(item.message)
                        .font(.subheadline.weight(.semibold))
                        .lineLimit(2)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .background(item.style.bg)
                .foregroundStyle(item.style.fg)
                .clipShape(Capsule())
                .padding(.horizontal, 20)
                .padding(.bottom, 82)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .onTapGesture { manager.dismiss() }
                .accessibilityLabel(item.message)
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.9), value: manager.current != nil)
        .allowsHitTesting(manager.current != nil)
    }
}

public struct GlobalSnackbarModifier: ViewModifier {
    @StateObject private var manager = SnackbarManager()
    public func body(content: Content) -> some View {
        content
            .environmentObject(manager)
            .overlay(SnackbarHostView(manager: manager).ignoresSafeArea())
    }
}

public extension View {
    func withGlobalSnackbar() -> some View {
        self.modifier(GlobalSnackbarModifier())
    }
}
