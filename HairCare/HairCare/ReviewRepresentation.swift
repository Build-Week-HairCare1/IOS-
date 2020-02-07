//
//  ReviewRepresentation.swift
//  HairCare
//
//  Created by Tobi Kuyoro on 06/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation

struct ReviewRepresentation: Codable {
    let title: String
    let description: String
    let stars: Int
    let stylist: Int
    let customer: Int
    let id: Int
}
