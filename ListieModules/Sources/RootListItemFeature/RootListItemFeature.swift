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
public struct RootListItemFeature {

    @ObservableState
    public struct State: Equatable {
        var listItem: ListItem

        public init(listItem: ListItem) {
            self.listItem = listItem
        }
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
    }

    public var body: some ReducerOf<RootListItemFeature> {
        BindingReducer()
    }
}

struct RootListItem: View {
    @Bindable var store: StoreOf<RootListItemFeature>

    var body: some View {
        TextField("Untitled Todo", text: $store.listItem.text )
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
