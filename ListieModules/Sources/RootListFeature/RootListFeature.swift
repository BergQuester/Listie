//
//  RootListFeature.swift
//  Listie
//
//  Created by Daniel Bergquist on 11/14/23.
//

import SwiftUI
import ComposableArchitecture
import Models

@Reducer
public struct RootListFeature {
    public init() { }

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

    let store: StoreOf<RootListFeature>

    public var body: some View {
        WithViewStore(store, observe: \.items) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.state) { item in
                        Text(item.text)
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItemGroup {
                    HStack {
                        #if os(iOS)
                        EditButton()
                        #endif
                        Button(action: { viewStore.send(.addItem) } ) {
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
            initialState: RootListFeature.State(items: [.init(id: ListItem.ID(.init()), text: "Test")]),
            reducer: RootListFeature.init
        )
    )
}
