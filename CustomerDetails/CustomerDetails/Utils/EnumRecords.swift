//
//  EnumRecords.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

enum CustomTab: String, CaseIterable {
    case home = "house"
    case userList = "person.3"
    case add = "plus"
    case products = "shippingbox"
    case purchaseList = "creditcard"
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .userList: return "Users"
        case .add: return ""
        case .products: return "Items"
        case .purchaseList: return "Sales"
        }
    }
    var isCenter: Bool {
        self == .add
    }
}
