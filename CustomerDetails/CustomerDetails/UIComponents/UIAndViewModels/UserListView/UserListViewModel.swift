//
//  UserListViewModel.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI
import CoreData

class UserListViewModel: ObservableObject {
    @Published var customers: [CustomerEntity] = []

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchCustomers()
    }

    func fetchCustomers() {
        let request: NSFetchRequest<CustomerEntity> = CustomerEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CustomerEntity.name, ascending: true)]

        do {
            customers = try context.fetch(request)
        } catch {
            print("Failed to fetch customers: \(error)")
            customers = []
        }
    }
    
    func deleteCustomer(_ customer: CustomerEntity) {
        context.delete(customer)
        do {
            try context.save()
            fetchCustomers() 
        } catch {
            print("Failed to delete: \(error)")
        }
    }
    
   
    

    
}
