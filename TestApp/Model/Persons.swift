//
//  People.swift
//  TestApp
//
//  Created by Li on 7/13/20.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation

struct Person: Codable {
    var id: Int
    var firstName, lastName, email: String
    var gender: Gender
    var dateOfBirtdh: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, gender, dateOfBirtdh
    }
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
}

