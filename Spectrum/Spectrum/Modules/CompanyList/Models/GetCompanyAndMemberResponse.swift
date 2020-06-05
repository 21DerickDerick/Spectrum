//
//  GetCompanyAndMemberResponse.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import Foundation

import Foundation

class Company: Codable {
    let id, name, website: String?
    let logo: String?
    let about: String?
    let members: [Member]
    var isFavorite = false
    var isFollowed = false

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "company"
        case website, logo, about, members
    }
}

class Member: Codable {
    let id: String?
    let age: Int?
    let name: Name?
    let email, phone: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case age, name, email, phone
    }
}

class Name: Codable {
    let first, last: String?
}
