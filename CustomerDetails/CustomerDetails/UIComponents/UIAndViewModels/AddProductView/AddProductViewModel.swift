//
//  AddProductViewModel.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 13/06/25.
//

import Foundation
import CoreData

class AddProductViewModel: ObservableObject {
    // MARK: - Input Properties
    @Published var productName: String = ""
    @Published var costText: String = ""
    
    // MARK: - Alert State
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    
    private let viewContext: NSManagedObjectContext
    private var existingProduct: ProductEntity?
    
    // MARK: - Init with Dependency Injection
    init(context: NSManagedObjectContext, product: ProductEntity? = nil) {
        self.viewContext = context
        self.existingProduct = product
        
        if let product = product {
            self.productName = product.productName ?? ""
            self.costText = "\(product.cost)"
        }
    }
    
    
    func saveProduct(_ isUpdate : Bool, productToEdit : ProductEntity?) {
        
        let result = validateProductInput(productName,costText)

        if result.isValid {
            saveProductDetails()
            
        } else {
            alertMessage = result.message
            showAlert = true
        }
        
    }

    
    
    
    // MARK: - Save Method
    func saveProductDetails() {
        let newProduct = existingProduct ?? ProductEntity(context: viewContext)
        
        if existingProduct == nil{
            newProduct.id = UUID()
        }
        
        newProduct.productName = productName
        newProduct.cost = Double(costText) ?? 0.0
        
        
        do {
            try viewContext.save()
            alertMessage = existingProduct == nil ? "Product added successfully!" : "Product updated successfully!"
            showAlert = true
            resetForm()
        } catch {
            alertMessage = "Failed to save product: \(error.localizedDescription)"
            showAlert = true
        }
    }
    
    func isNewProduct(_ isUpdate : Bool)->Bool{
        
        guard !isUpdate else {return true}

        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        request.predicate = NSPredicate(format: "productName = [c] %@", productName)
        
        var result = [ProductEntity]()
        do {
            result = try viewContext.fetch(request)
            
        } catch {
            print("Failed to fetch products: \(error)")
            
        }
        
        
        
        if result.count > 0{
            alertMessage = "Product already exists. Please use different details"
            showAlert = true
        }
        return result.count > 0 ? false : true
    }
    
  
    
    // MARK: - Reset Form
    private func resetForm() {
        productName = ""
        costText = ""
    }
    
    // MARK: - Data Validation
    
    func validateProductInput(_ productName: String,_ cost: String) -> (isValid: Bool, message: String) {
      
        // Name
        guard !productName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return (false, "Please enter product name.")
        }
        
        guard !cost.isEmpty else {
            return (false, "Cost cannot be empty")
        }
        
        guard let value = Double(cost), value >= 0 else {
            return (false, "Enter a valid positive numbe")
        }


        return (true, "All fields are valid.")
    }
  
    
}
