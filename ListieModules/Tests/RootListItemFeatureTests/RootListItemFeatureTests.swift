//
//  RootListItemFeatureTests.swift
//  
//
//  Created by Daniel Bergquist on 12/5/23.
//

import XCTest
@testable import RootListItemFeature
import Models

import ComposableArchitecture

@MainActor
final class RootListItemFeatureTests: XCTestCase {

    func testEditItem() async {
        let store = TestStore(initialState: RootListItemFeature.State(listItem: ListItem.mock))
        { RootListItemFeature() }

        await store.send(.set(\.listItem.text, "test")) {
            $0.listItem.text = "test"
        }

        await store.send(.set(\.listItem.complete, true)) {
            $0.listItem.complete = true
        }
    }
}
