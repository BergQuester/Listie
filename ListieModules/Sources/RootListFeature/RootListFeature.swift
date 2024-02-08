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
        public var items: IdentifiedArrayOf<RootListItemFeature.State>

        public init(items: IdentifiedArrayOf<RootListItemFeature.State>) {
            self.items = items
        }
    }

    public enum Action {
        case addItem
        case item(IdentifiedActionOf<RootListItemFeature>)
    }

    @Dependency(\.uuid) var UUID

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addItem:
                state.items.append(.init(listItem: .init(id: ListItem.ID(UUID()), text: "", complete: false)))
                return .none
            case .item:
                return .none
            }
        }
        .forEach(\.items, action: \.item) {
            RootListItemFeature()
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
                ForEach(store.scope(state: \.items, action: \.item)) { store in
                    RootListItem(store: store)
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
                .init(listItem: .init(id: ListItem.ID(.init()), text: "Test", complete: false)),
                .init(listItem: .init(id: ListItem.ID(.init()), text: "Test2", complete: false)),
                .init(listItem: .init(id: ListItem.ID(.init()), text: "Test3", complete: true)),
            ]),
            reducer: RootListFeature.init
        )
    )
}
