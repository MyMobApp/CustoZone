//
//  ProductEntity+CoreDataProperties.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var productName: String?
    @NSManaged public var cost: Double
    @NSManaged public var purchases: NSSet?

}

// MARK: Generated accessors for purchases
extension ProductEntity {

    @objc(addPurchasesObject:)
    @NSManaged public func addToPurchases(_ value: Purchase)

    @objc(removePurchasesObject:)
    @NSManaged public func removeFromPurchases(_ value: Purchase)

    @objc(addPurchases:)
    @NSManaged public func addToPurchases(_ values: NSSet)

    @objc(removePurchases:)
    @NSManaged public func removeFromPurchases(_ values: NSSet)

}

extension ProductEntity : Identifiable {

}
