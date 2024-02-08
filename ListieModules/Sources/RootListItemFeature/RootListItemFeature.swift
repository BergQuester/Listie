//
//  RootListItemFeature.swift
//  
//
//  Created by Daniel Bergquist on 12/5/23.
//

import ComposableArchitecture
import Models
import Tagged

import SwiftUI

@Reducer
public struct RootListItemFeature {

    @ObservableState
    public struct State: Equatable, Identifiable {
        var listItem: ListItem
        public var id: ListItem.ID { listItem.id }

        public init(listItem: ListItem) {
            self.listItem = listItem
        }
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
    }

    public init() { }

    public var body: some ReducerOf<RootListItemFeature> {
        BindingReducer()
    }
}

public struct RootListItem: View {
    @Bindable var store: StoreOf<RootListItemFeature>

    public init(store: StoreOf<RootListItemFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Toggle(isOn: $store.listItem.complete) {
            TextField("Untitled Todo", text: $store.listItem.text)
        }
    }
}

extension ListItem {
    static var mock: ListItem {
        ListItem(id: ListItem.ID(UUID()), text: "A list Item", complete: false)
    }
}

#Preview {
    RootListItem(store:
                    Store(initialState: RootListItemFeature.State(listItem: ListItem.mock)) {
                    RootListItemFeature()
        }
    )
}
