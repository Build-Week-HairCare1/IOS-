//
//  SignUpUser.swift
//  HairCare
//
//  Created by Tobi Kuyoro on 06/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation

struct SignUpUser: Codable {
    let firstName: String
    let lastName: String
    let city: String
    let state: String
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case city
        case state
        case email
        case password
    }
}
