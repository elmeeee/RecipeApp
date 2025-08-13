//
//  RecipeDecodingTests.swift
//  RecipeApp
//
//  Created by Elmee on 13/08/25.
//

import XCTest
@testable import RecipeApp

final class RecipeDecodingTests: XCTestCase {
    func testDecodeRecipes() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "recipes", withExtension: "json") else {
            XCTFail("Missing recipes.json in test bundle")
            return
        }
        let data = try Data(contentsOf: url)
        let recipes = try JSONDecoder().decode([Recipe].self, from: data)
        XCTAssertFalse(recipes.isEmpty)
        XCTAssertEqual(recipes.first?.id, "r1")
    }
}
