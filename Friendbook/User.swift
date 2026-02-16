//
//  Response.swift
//  Friendbook
//
//  Created by Mohit Sengar on 15/02/26.
//

import Foundation
import SwiftData

@Model
final class User: Codable, Hashable {

    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]

    enum CodingKeys: String, CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }

    // MARK: - Decodable
    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)

        id = try c.decode(String.self, forKey: .id)
        isActive = try c.decode(Bool.self, forKey: .isActive)
        name = try c.decode(String.self, forKey: .name)
        age = try c.decode(Int.self, forKey: .age)
        company = try c.decode(String.self, forKey: .company)
        email = try c.decode(String.self, forKey: .email)
        address = try c.decode(String.self, forKey: .address)
        about = try c.decode(String.self, forKey: .about)
        registered = try c.decode(Date.self, forKey: .registered)
        tags = try c.decode([String].self, forKey: .tags)
        friends = try c.decode([Friend].self, forKey: .friends)
    }

    // MARK: - Encodable
    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)

        try c.encode(id, forKey: .id)
        try c.encode(isActive, forKey: .isActive)
        try c.encode(name, forKey: .name)
        try c.encode(age, forKey: .age)
        try c.encode(company, forKey: .company)
        try c.encode(email, forKey: .email)
        try c.encode(address, forKey: .address)
        try c.encode(about, forKey: .about)
        try c.encode(registered, forKey: .registered)
        try c.encode(tags, forKey: .tags)
        try c.encode(friends, forKey: .friends)
    }

    // Normal initializer (SwiftData)
    init(
        id: String,
        isActive: Bool,
        name: String,
        age: Int,
        company: String,
        email: String,
        address: String,
        about: String,
        registered: Date,
        tags: [String],
        friends: [Friend]
    ) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
}

@Model
final class Friend: Codable, Hashable {

    var id: String
    var name: String

    enum CodingKeys: String, CodingKey {
        case id, name
    }

    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(String.self, forKey: .id)
        name = try c.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(id, forKey: .id)
        try c.encode(name, forKey: .name)
    }

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
