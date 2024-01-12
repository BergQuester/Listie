//
//  RootListFeature.swift
//  Listie
//
//  Created by Daniel Bergquist on 11/14/23.
//

import SwiftUI
import ComposableArchitecture

import RootListItemFeature
import Models

@Reducer
public struct RootListFeature {
    public init() { }

    @ObservableState
    public struct State {
        public var items: [ListItem]

        public init(items: [ListItem]) {
            self.items = items
        }
    }

    public enum Action {
        case addItem
    }

    @Dependency(\.uuid) var UUID

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addItem:
                state.items.append(.init(id: ListItem.ID(UUID()), text: ""))
                return .none
            }
        }
    }
}

public struct RootList: View {
    public init(store: StoreOf<RootListFeature>) {
        self.store = store
    }

    @Bindable var store: StoreOf<RootListFeature>

    public var body: some View {
        NavigationStack {
            List {
                ForEach(store.state.items) { item in
                    RootListItem(store: item.text)
                }
            }
            .padding()
            .toolbar {
                ToolbarItemGroup {
                    HStack {
#if os(iOS)
                        EditButton()
#endif
                        Button(action: { store.send(.addItem) } ) {
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
                .init(id: ListItem.ID(.init()), text: "Test"),
                .init(id: ListItem.ID(.init()), text: "Test2"),
                .init(id: ListItem.ID(.init()), text: "Test3"),
            ]),
            reducer: RootListFeature.init
        )
    )
}
