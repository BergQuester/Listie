//
//  File.swift
//  
//
//  Created by Daniel Bergquist on 2/23/24.
//

import SwiftUI
import ComposableArchitecture

import RootListItemFeature
import Models

#if os(tvOS)
public struct RootList: View {
    public init(store: StoreOf<RootListFeature>) {
        self.store = store
    }

    @Bindable var store: StoreOf<RootListFeature>

    public var body: some View {
        NavigationStack {
            List {
                ForEach(store.scope(state: \.items, action: \.item)) { store in
                    RootListItem(store: store)
                }
                .onDelete { store.send(.deleteItems($0)) }
            }
            .padding()
            .toolbar {
                ToolbarItemGroup {
                    HStack {
                        Button(action: { store.send(.addItem) }) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RootList(store: Store(
        initialState: RootListFeature.State(items: [
            .init(listItem: .init(id: ListItem.ID(.init()), text: "Test", complete: false)),
            .init(listItem: .init(id: ListItem.ID(.init()), text: "Test2", complete: false)),
            .init(listItem: .init(id: ListItem.ID(.init()), text: "Test3", complete: true)),
        ]),
        reducer: RootListFeature.init
    )
    )
}

#endif

