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
    public struct State: Equatable {
        public var items: IdentifiedArrayOf<RootListItemFeature.State>

        public init(items: IdentifiedArrayOf<RootListItemFeature.State>) {
            self.items = items
        }
    }

    public enum Action {
        case addItem
        case deleteItem(RootListItemFeature.State.ID)
        case deleteItems(IndexSet)
        case item(IdentifiedActionOf<RootListItemFeature>)
    }

    @Dependency(\.uuid) var UUID

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addItem:
                state.items.append(.init(listItem: .init(id: ListItem.ID(UUID()), text: "", complete: false)))
                return .none
            case let .deleteItem(id):
                state.items.remove(id: id)
                return .none
            case let .deleteItems(offsets):
                state.items.remove(atOffsets: offsets)
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
