//
//  Customer+Convenience.swift
//  HairCare
//
//  Created by Tobi Kuyoro on 05/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation
import CoreData

extension Customer {
    
    var customerRepresentation: CustomerRepresentation? {
        guard let firstName = firstName,
            let lastName = lastName,
            let city = city,
            let state = state,
            let email = email,
            let password = password else { return nil }
        
        return CustomerRepresentation(id: id, firstName: firstName, lastName: lastName, city: city, state: state, email: email, password: password)
    }
    
    convenience init(id: Int16, firstName: String, city: String, state: String, email: String, password: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.firstName = firstName
        self.city = city
        self.state = state
        self.email = email
        self.password = password
    }
    
    @discardableResult convenience init?(customerRepresentation: CustomerRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(id: customerRepresentation.id,
                      firstName: customerRepresentation.firstName,
                      city: customerRepresentation.city,
                      state: customerRepresentation.state,
                      email: customerRepresentation.email,
                      password: customerRepresentation.password,
                      context: context)
    }
}
