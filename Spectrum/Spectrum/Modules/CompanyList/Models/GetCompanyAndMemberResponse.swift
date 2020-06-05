//
//  GetCompanyAndMemberResponse.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import Foundation

import Foundation

struct Company: Codable {
    let id, name, website: String
    let logo: String
    let about: String
    let members: [Member]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "company"
        case website, logo, about, members
    }
}

struct Member: Codable {
    let id: String
    let age: Int
    let name: Name
    let email, phone: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case age, name, email, phone
    }
}

struct Name: Codable {
    let first, last: String
}
