//
//  File.swift
//  
//
//  Created by Jimmy McDermott on 4/10/20.
//

import Foundation
import Vapor

@available(macOS 12.0.0, *)
extension Request {
    public var swiftPwned: PwnedClient {
        .init(client: self.client)
    }
}
