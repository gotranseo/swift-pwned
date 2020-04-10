//
//  File.swift
//  
//
//  Created by Jimmy McDermott on 4/10/20.
//

import Foundation
import Vapor

extension Request {
    public var swiftPwned: PwnedClient {
        .init(client: self.client)
    }
}
