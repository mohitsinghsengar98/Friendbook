//
//  Response.swift
//  Friendbook
//
//  Created by Mohit Sengar on 15/02/26.
//

import Foundation

struct User : Codable,Hashable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company : String
    let email : String
    let address: String
    let about : String
    let registered: Date
    let tags: [String]
    let friends : [Friend]
}

struct Friend : Codable,Hashable{
    let id: String
    let name: String
}
