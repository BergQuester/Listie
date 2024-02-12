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
        HStack {
            TextField("Untitled Todo", text: $store.listItem.text)
#if os(macOS)
            Button("\(Image(systemName: "trash.circle"))") {
            }
            .buttonStyle(.borderless)
            .font(.title)
            .foregroundColor(.red)
#endif

            Toggle("Completed", isOn: $store.listItem.complete)
                .toggleStyle(.completion)
        }
    }
}

struct CompletionToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        Group {
            if configuration.isOn {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .font(.title)
    }
}

extension ToggleStyle where Self == CompletionToggleStyle {
    static var completion: CompletionToggleStyle { .init() }
}


extension ListItem {
    static var mock: ListItem {
        ListItem(id: ListItem.ID(UUID()), text: "A list Item", complete: false)
    }
}

#Preview {
    VStack {
        RootListItem(store:
                        Store(initialState: RootListItemFeature.State(listItem: ListItem.mock)) {
                RootListItemFeature()
            }
        )
        RootListItem(store:
                        Store(initialState: RootListItemFeature.State(
                            listItem: ListItem(id: RootListItemFeature.State.ID(),
                                               text: "Another List Item",
                                               complete: true)
                                              )
                              ) {
            RootListItemFeature()
        }
        )
    }
    .padding()
}
