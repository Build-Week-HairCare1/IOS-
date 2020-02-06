//
//  CustomerRepresentation.swift
//  HairCare
//
//  Created by Tobi Kuyoro on 05/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation

struct CustomerRepresentation: Codable {
    let id: Int16
    let firstName: String
    let lastName: String
    let city: String
    let state: String
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case city
        case state
        case email
        case password
    }
}
