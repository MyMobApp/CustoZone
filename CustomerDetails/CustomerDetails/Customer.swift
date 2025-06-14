//
//  Customer.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import Foundation

struct Customer: Identifiable, Equatable {
    let id: UUID
    var name: String
    var email: String
    var phone: String

    init(id: UUID = UUID(), name: String, email: String, phone: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
    }
}


