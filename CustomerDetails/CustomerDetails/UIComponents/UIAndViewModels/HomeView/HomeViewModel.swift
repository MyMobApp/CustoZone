//
//  HomeViewModel.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 13/06/25.
//

import CoreData
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var purchaseList: [Purchase] = []
    @Published var customerList: [CustomerEntity] = []
    
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchHighestPurchases()
        fetchNewlyAddedCustomers()
    }
    
    func fetchHighestPurchases() {
        
        let request: NSFetchRequest<Purchase> = Purchase.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Purchase.totalCost, ascending: false)]
        request.fetchLimit = 5

        do {
            purchaseList = try context.fetch(request)
        } catch {
            print("Failed to fetch top purchases: \(error)")
            purchaseList = []
        }
    }
    
    
    func fetchNewlyAddedCustomers() {
        
        let request: NSFetchRequest<CustomerEntity> = CustomerEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "objectID", ascending: false)]
        request.fetchLimit = 5
        do {
            customerList = try context.fetch(request)
        } catch {
            print("Failed to fetch latest customers: \(error)")
            customerList = []
        }
    }

    

}
