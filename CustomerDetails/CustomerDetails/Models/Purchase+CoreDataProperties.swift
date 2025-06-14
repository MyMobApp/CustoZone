//
//  Purchase+CoreDataProperties.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//
//

import Foundation
import CoreData


extension Purchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Purchase> {
        return NSFetchRequest<Purchase>(entityName: "PurchaseEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var purchaseDate: Date?
    @NSManaged public var totalCost: Double
    @NSManaged public var user: CustomerEntity?
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension Purchase {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: ProductEntity)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: ProductEntity)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension Purchase : Identifiable {

}
