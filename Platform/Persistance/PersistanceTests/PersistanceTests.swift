//
//  PersistanceTests.swift
//  PersistanceTests
//
//  Created by Milton Palaguachi on 5/21/23.
//

import XCTest
@testable import Persistance

final class PersistanceTests: XCTestCase {

    func testSaveAndRead() throws {
        // Given
        let preference = PreferenceStoreManager()
        let testModel = TestModel()

        // When
        try preference.saveUserDefaults(testModel)
        let expeectTextModel: TestModel? = try preference.readUserDefaults()
    
        // Then
        XCTAssertEqual(expeectTextModel?.hello, "Hellow World!")
    }

    func testDeleteDataFrom_UserDefaults() throws {
        // Given
        let preference = PreferenceStoreManager()
        let testModel: TestModel? = nil

        // When
        try preference.saveUserDefaults(testModel)
        let expeectTextModel: TestModel? = try preference.readUserDefaults()

        // Then
        XCTAssertNil(expeectTextModel)
    }
}

struct TestModel: PreferenceModel {
    static var keyIdentifier: String {
        "TestModel"
    }
    var hello = "Hellow World!"
}
