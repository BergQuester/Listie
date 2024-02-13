//
//  RootListFeatureTests.swift
//
//
//  Created by Daniel Bergquist on 11/21/23.
//

import XCTest
@testable import RootListFeature
import RootListItemFeature
import Models

import ComposableArchitecture

@MainActor
final class RootListFeatureTests: XCTestCase {
    func testEditList() async {
        let store = TestStore(initialState: RootListFeature.State(items: [])) {
            RootListFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }

        // Add an item
        await store.send(.addItem) {
            $0.items = [
                RootListItemFeature.State(listItem: ListItem(id: .init(UUID(0)),
                                                             text: "",
                                                             complete: false))
            ]
        }

        // Add a second item
        await store.send(.addItem) {
            $0.items = [
                RootListItemFeature.State(listItem: ListItem(id: .init(UUID(0)),
                                                             text: "",
                                                             complete: false)),
                RootListItemFeature.State(listItem: ListItem(id: .init(UUID(1)),
                                                             text: "",
                                                             complete: false))
            ]
        }

        // Title Item
        await store.send(.item(.element(id: .init(UUID(0)), action: .set(\.listItem.text, "My wonderful to do item")))) {
            $0.items[0].listItem.text = "My wonderful to do item"
        }

        // complete item
        await store.send(.item(.element(id: .init(UUID(0)), action: .set(\.listItem.complete, true)))) {
            $0.items[0].listItem.complete = true
        }
    }
}
