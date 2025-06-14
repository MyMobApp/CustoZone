//
//  AddPurchaseViewModel.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 13/06/25.
//

import Foundation
import CoreData

class AddPurchaseViewModel: ObservableObject {
    
    private let viewContext: NSManagedObjectContext
    // MARK: - Form State
    @Published var purchaseDate = Date()
    @Published var totalCostText = ""
    @Published var selectedUser: CustomerEntity?
    @Published var selectedProducts = Set<ProductEntity>()
    @Published var totalCost: Double = 0.0
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    
    
    @Published var products: [ProductEntity] = []
    @Published var customers: [CustomerEntity] = []
    
  
    // MARK: - Init with Dependency Injection
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchUsers()
        fetchProducts()
    }
    
    func isCostTextTapped(){
        alertMessage = "Cost cannot be entered manually. Try to select a product instead"
        showAlert = true
    }
    
    func isCustomerTextTapped(){
        alertMessage = "Please add the customer first"
        showAlert = true
    }
    
    func isProcuctTextTapped(){
        alertMessage = "Please add the product first"
        showAlert = true
    }
    
    func fetchProducts() {
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ProductEntity.productName, ascending: true)]

        do {
            products = try viewContext.fetch(request)
        } catch {
            print("Failed to fetch products: \(error)")
            products = []
        }
    }
    
  
    func fetchUsers() {
        let request: NSFetchRequest<CustomerEntity> = CustomerEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CustomerEntity.name, ascending: true)]

        do {
            customers = try viewContext.fetch(request)
        } catch {
            print("Failed to fetch users: \(error.localizedDescription)")
        }
    }
    
    
    func validateUserInput(_ purchaseDate: Date?,_ totalCost: Double,_ user: CustomerEntity?,_ products: NSSet?) -> (isValid: Bool, message: String) {
        
        if purchaseDate == nil {
            return (false, "Purchase date is required.")
        } else if let date = purchaseDate, date > Date() {
            return (false, "Purchase date cannot be in the future")
        }
        
        if totalCost <= 0 {
            return (false, "Total cost must be greater than zero.")
        }
        
        if user == nil {
            return (false, "A customer must be selected.")
        }
        
        if let productSet = products, productSet.count == 0 {
            return (false, "At least one product must be selected.")
        } else if products == nil {
            return (false, "Products list is required.")
        }
        
        return (true, "All fields are valid.")
    }
    
    func updateTotalCostText() {
        totalCostText = String(format: "%.2f", totalCost)
    }
    
    
    
    func savePurchase() {
        
        let result = validateUserInput(purchaseDate, Double(totalCostText) ?? 0.0, selectedUser, selectedProducts as NSSet)

        if result.isValid {
            savePurchaseDetails()
        } else {
            alertMessage = result.message
            showAlert = true
        }
        
        

    }
    
    func savePurchaseDetails(){
        let newPurchase = Purchase(context: viewContext)
        newPurchase.id = UUID()
        newPurchase.purchaseDate = purchaseDate
        newPurchase.totalCost = totalCost
        newPurchase.user = selectedUser
        newPurchase.products = NSSet(set: selectedProducts)
        
        do {
            try viewContext.save()
            resetFields()
            alertMessage = "Purchase added successfully!"
            showAlert = true
        } catch {
            print("Save failed: \(error)")
        }
    }
    
    func resetFields(){
        purchaseDate = Date()
        totalCost = 0.0
        totalCostText = "0.0"
        selectedUser = nil
        selectedProducts.removeAll()
    }
    
    
}
