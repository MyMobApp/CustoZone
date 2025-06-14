//
//  APIModels.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 14/06/25.
//

import Foundation

import Foundation

struct APICustomer: Codable {
    var id : Int
    var name: String
    var email: String
    var gender: String
    var status: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case gender
        case status
    }
}
