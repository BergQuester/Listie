//
//  Listie_WatchOSApp.swift
//  Listie WatchOS Watch App
//
//  Created by Daniel Bergquist on 2/23/24.
//

import SwiftUI
import ComposableArchitecture
import RootListFeature
import Models

@main
struct Listie_WatchOS_Watch_AppApp: App {
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
