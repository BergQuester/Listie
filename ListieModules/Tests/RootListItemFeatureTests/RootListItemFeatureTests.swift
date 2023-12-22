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


class RootListItemFeatureTests: XCTestCase {

    func testFeature() async {
        let store = TestStore(initialState: RootListItemFeature.State(listItem: ListItem.mock))
        { RootListItemFeature() }


    }
}
