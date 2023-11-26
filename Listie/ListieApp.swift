//
//  ListieApp.swift
//  Listie
//
//  Created by Daniel Bergquist on 11/14/23.
//

import SwiftUI
import ComposableArchitecture
import RootListFeature
import Models

@main
struct ListieApp: App {
    var body: some Scene {
        WindowGroup {
            RootList(store: Store(
                    initialState: RootListFeature.State(items: []),
                    reducer: RootListFeature.init
                )
            )
        }
    }
}
