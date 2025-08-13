//
//  HomeViewModelTests.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//

import XCTest
@testable import RecipeApp

final class HomeViewModelTests: XCTestCase {
    @MainActor func testSortAndFilter() async throws {
        let repo = CombinedRepository()
        let favs = FavoritesStore()
        let vm = HomeViewModel(repo: repo, favorites: favs)
        vm.setSourceLocal()
        vm.load()
        try? await Task.sleep(nanoseconds: 600_000_000)
        vm.selectedTags = ["quick"]
        vm.applyFilters()
        XCTAssertTrue(vm.filtered.allSatisfy { $0.tags.contains("quick") })
    }
}
