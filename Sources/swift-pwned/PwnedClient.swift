//
//  File.swift
//  
//
//  Created by Jimmy McDermott on 12/4/19.
//

import Foundation
import Vapor
import Crypto

public struct PwnedClient: Service {
    let client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    internal func generateHash(input: String) throws -> String {
        return try SHA1.hash(input).hexEncodedString().uppercased()
    }
    
    internal func getHeadAndTail(input: String) -> (head: String, tail: String) {
        let head = String(input.prefix(5))
        let range = input.index(input.startIndex, offsetBy: 5)..<input.endIndex
        let tail = String(input[range])
        
        return (head, tail)
    }
    
    internal func getHashed(firstFive: String) throws -> Future<[PwnedResponse]> {
        let url = "https://api.pwnedpasswords.com/range/\(firstFive)"
        return client.get(url).map { res in
            guard let data = res.http.body.data else { throw Abort(.badRequest) }
            guard let string = String(data: data, encoding: .utf8) else { throw Abort(.badRequest) }
            
            return string
                .split(separator: "\r\n")
                .map { $0.split(separator: ":") }
                .filter { $0.count == 2 }
                .compactMap { data in
                    guard let count = Int(data[1]) else { return nil }
                    let hash = String(data[0])
                    return PwnedResponse(hash: hash, count: count)
            }
        }
    }
    
    public func pwned(password: String) throws -> Future<Bool> {
        let hash = try generateHash(input: password)
        let headTail = getHeadAndTail(input: hash)
        let firstFive = headTail.head
        
        return try getHashed(firstFive: firstFive).map { results in
            return results.contains(where: { $0.hash == headTail.tail })
        }
    }
}

public struct PwnedResponse: Content {
    let hash: String
    let count: Int
}
