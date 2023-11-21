//
//  RootListFeature.swift
//  Listie
//
//  Created by Daniel Bergquist on 11/14/23.
//

import SwiftUI

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
