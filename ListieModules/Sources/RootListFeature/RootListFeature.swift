//
//  RootListFeature.swift
//  Listie
//
//  Created by Daniel Bergquist on 11/14/23.
//

import SwiftUI
import ComposableArchitecture

struct RootListFeature: Reducer {
    struct State {

    }

    enum Action {
        case test
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .test:
                return .none
            }
        }
    }
}

public struct RootList: View {
    public init() { }
    
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    RootList()
}
