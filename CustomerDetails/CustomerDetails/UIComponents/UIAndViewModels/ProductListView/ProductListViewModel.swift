//
//  ProductListViewModel.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 13/06/25.
//

import CoreData

class ProductListViewModel: ObservableObject {
    
    @Published var products: [ProductEntity] = []
    @Published var itemName : String = ""
    @Published var itemCost : String = ""
    @Published var itemId : String = ""
    @Published var showAddProduct = false
    
    
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchProducts()
    }
    
    func fetchProducts() {
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ProductEntity.productName, ascending: true)]

        do {
            products = try context.fetch(request)
        } catch {
            print("Failed to fetch customers: \(error)")
            products = []
        }
    }
    
    func deleteProduct(_ customer: ProductEntity) {
        context.delete(customer)
        do {
            try context.save()
            fetchProducts()
        } catch {
            print("Failed to delete: \(error)")
        }
    }
}
