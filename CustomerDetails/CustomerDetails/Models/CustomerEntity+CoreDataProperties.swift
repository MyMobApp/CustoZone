//
//  CustomerEntity+CoreDataProperties.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//
//

import Foundation
import CoreData


extension CustomerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomerEntity> {
        return NSFetchRequest<CustomerEntity>(entityName: "CustomerEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var address: String?
    @NSManaged public var dob: Date?
    @NSManaged public var gender: String?
    @NSManaged public var products: NSSet?
    @NSManaged public var purchases: NSSet?

}

// MARK: Generated accessors for products
extension CustomerEntity {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: ProductEntity)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: ProductEntity)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

// MARK: Generated accessors for purchases
extension CustomerEntity {

    @objc(addPurchasesObject:)
    @NSManaged public func addToPurchases(_ value: Purchase)

    @objc(removePurchasesObject:)
    @NSManaged public func removeFromPurchases(_ value: Purchase)

    @objc(addPurchases:)
    @NSManaged public func addToPurchases(_ values: NSSet)

    @objc(removePurchases:)
    @NSManaged public func removeFromPurchases(_ values: NSSet)

}

extension CustomerEntity : Identifiable {

}
