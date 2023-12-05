//
//  RootListItemFeature.swift
//  
//
//  Created by Daniel Bergquist on 12/5/23.
//

import ComposableArchitecture
import Models

import SwiftUI

@Reducer
struct RootListItemFeature {
    struct State: Equatable {
        @BindingState var listItem: ListItem

        public init(listItem: ListItem) {
            self.listItem = listItem
        }
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }

    var body: some ReducerOf<RootListItemFeature> {
        BindingReducer()
    }
}

struct RootListItem: View {
    let store: StoreOf<RootListItemFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            TextField("Untitled Todo", text: viewStore.$listItem.text )
        }
    }
}

extension ListItem {
    static var mock: ListItem {
        ListItem(id: ListItem.ID(UUID()), text: "A list Item")
    }
}

#Preview {
    RootListItem(store:
                    Store(initialState: RootListItemFeature.State(listItem: ListItem.mock)) {
                    RootListItemFeature()
        }
    )
}
