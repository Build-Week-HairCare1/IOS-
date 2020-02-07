//
//  StylistRepresentation.swift
//  HairCare
//
//  Created by Tobi Kuyoro on 05/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation

struct StylistRepresentation: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let bio: String
    let city: String
    let state: String
    let email: String
    let password: String
    let photo: String
    let specialty: String
    let reviews: ReviewRepresentation
    
    enum CodingKeys: String, CodingKey {
        case id 
        case firstName = "first_name"
        case lastName = "last_name"
        case bio
        case city
        case state
        case email
        case password
        case photo = "photo_url"
        case specialty
        case reviews
    }
}


