//
//  PurchaseListViewModel.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 13/06/25.
//

import Foundation
import CoreData

class PurchaseListViewModel: ObservableObject {
    
    @Published var purchaseList: [Purchase] = []

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchPurchases()
    }

    func fetchPurchases() {
        let request: NSFetchRequest<Purchase> = Purchase.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Purchase.id, ascending: false)]

        do {
            purchaseList = try context.fetch(request)
        } catch {
            print("Failed to fetch customers: \(error)")
            purchaseList = []
        }
    }
    
    func deleteCustomer(_ customer: Purchase) {
        context.delete(customer)
        do {
            try context.save()
            fetchPurchases()
        } catch {
            print("Failed to delete: \(error)")
        }
    }
    
    
    func formatDate(_ date : Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
   
   
    
}
