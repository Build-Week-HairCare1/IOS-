//
//  Stylist+Convenience.swift
//  HairCare
//
//  Created by Tobi Kuyoro on 05/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation
import CoreData

extension Stylist {
    
    var stylistRepresentation: StylistRepresentation? {
        guard let firstName = firstName,
            let lastName = lastName,
            let city = city,
            let state = state,
            let email = email,
            let password = password,
            let photo = photo,
            let specialty = specialty else { return nil }
        
        return StylistRepresentation(id: id, firstName: firstName, lastName: lastName, city: city, state: state, email: email, password: password, photo: photo, specialty: specialty)
    }
    
    convenience init(id: Int16, firstName: String, lastName: String, city: String, state: String, email: String, password: String, photo: String, specialty: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.city = city
        self.state = state
        self.email = email
        self.password = password
        self.photo = photo
        self.specialty = specialty
    }
    
    @discardableResult convenience init?(stylistRepresentation: StylistRepresentation, context: NSManagedObjectContext) {
        self.init(id: stylistRepresentation.id,
                  firstName: stylistRepresentation.firstName,
                  lastName: stylistRepresentation.lastName,
                  city: stylistRepresentation.city,
                  state: stylistRepresentation.state,
                  email: stylistRepresentation.email,
                  password: stylistRepresentation.password,
                  photo: stylistRepresentation.photo,
                  specialty: stylistRepresentation.specialty,
                  context: context)
    }
}
