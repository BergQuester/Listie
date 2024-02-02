//
//  ListItem.swift
//
//
//  Created by Daniel Bergquist on 11/25/23.
//

import Foundation
import Tagged

public struct ListItem: Equatable, Identifiable {
    public let id: ID
    public var text: String
    public var complete: Bool

    public typealias ID = Tagged<ListItem, UUID>

    public init(id: ID, text: String, complete: Bool) {
        self.id = id
        self.text = text
        self.complete = complete
    }
}
