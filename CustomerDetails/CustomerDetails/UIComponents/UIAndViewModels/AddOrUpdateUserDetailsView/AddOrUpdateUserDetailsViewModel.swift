//
//  AddOrUpdateUserDetailsViewModel.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import Foundation
import CoreData

class AddOrUpdateUserDetailsViewModel: ObservableObject {
    // MARK: - Input Properties
    @Published var id = UUID()
    @Published var name = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var address = ""
    @Published var dob = Date()
    @Published var gender = "Male"
    
    // MARK: - Alert State
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    
    private let viewContext: NSManagedObjectContext
    private var existingCustomer: CustomerEntity?
    
    // MARK: - Init with Dependency Injection
    init(context: NSManagedObjectContext, customer: CustomerEntity? = nil) {
        self.viewContext = context
        self.existingCustomer = customer
        
        if let customer = customer {
            self.id = customer.id ?? UUID()
            self.name = customer.name ?? ""
            self.email = customer.email ?? ""
            self.phone = customer.phone ?? ""
            self.address = customer.address ?? ""
            self.gender = customer.gender ?? "Male"
            self.dob = customer.dob ?? Date()
        }
    }
    
    
    func saveUser(_ isUpdate : Bool, customerToEdit : CustomerEntity?){
        
        if isUpdate{
            if let customerToEdit = customerToEdit{
                updateCustomerDetails(customerToEdit)
            }
            
        }else{
            saveCustomerDetails()
        }
    }

    
    func isNewCustomer(_ isUpdate : Bool)->Bool{
        
        guard !isUpdate else {return true}
        let request: NSFetchRequest<CustomerEntity> = CustomerEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name = [c] %@ && phone = %@", name, phone)
        
        var result = [CustomerEntity]()
        do {
            result = try viewContext.fetch(request)
            
        } catch {
            print("Failed to fetch customers: \(error)")
            
        }
        
        if result.count > 0{
            alertMessage = "Customer already exists. Please use different details"
            showAlert = true
        }
        return result.count > 0 ? false : true
    }
    
    
    
    // MARK: - Save Method
    func saveCustomerDetails() {
        let newCustomer = CustomerEntity(context: viewContext)
        newCustomer.id = id
        newCustomer.name = name
        newCustomer.email = email
        newCustomer.phone = phone
        newCustomer.address = address
        newCustomer.dob = dob
        newCustomer.gender = gender
        
        do {
            try viewContext.save()
            alertMessage = "Customer saved successfully!"
            showAlert = true
            resetForm()
        } catch {
            alertMessage = "Failed to save customer: \(error.localizedDescription)"
            showAlert = true
        }
    }
    
    func updateCustomerDetails(_ customer : CustomerEntity) {
        
        customer.name = name
        customer.email = email
        customer.phone = phone
        customer.address = address
        customer.dob = dob
        customer.gender = gender
        
        do {
            try viewContext.save()
            alertMessage = "Details updated successfully!"
            showAlert = true
            resetForm()
        } catch {
            alertMessage = "Failed to update customer: \(error.localizedDescription)"
            showAlert = true
        }
    }
    
    // MARK: - Reset Form
    private func resetForm() {
        name = ""
        email = ""
        phone = ""
        address = ""
        dob = Date()
        gender = "Male"
    }
    
    // MARK: - Data Validation
    
    func validateUserInput(_ name: String,_ email: String,_ phone: String,_ address: String, _ dob: Date,_ gender: String){
      
        // Name
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            alertMessage = "Please enter your name."
            showAlert = true
            return
        }

        // Email
        let emailRegex = #"^\S+@\S+\.\S+$"#
        if !NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) {
            alertMessage = "Please enter a valid email address."
            showAlert = true
        }

        // Phone
        let digitsOnly = phone.filter { "0123456789".contains($0) }
        if digitsOnly.count < 10 || digitsOnly.count > 15 {
            alertMessage = "Please enter a valid phone number."
            showAlert = true
        }

        // Address
        guard !address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            alertMessage = "Please enter your address."
            showAlert = true
            return
        }

        // DOB
        let calendar = Calendar.current
        let age = calendar.dateComponents([.year], from: dob, to: Date()).year ?? 0
        if age < 5 {
            alertMessage = "Please enter a valid date of birth."
            showAlert = true
        }

        // Gender
        let validGenders = ["Male", "Female"]
        if !validGenders.contains(gender) {
            alertMessage = "Please select a valid gender"
            showAlert = true
        }
    }
      
    func buildAPICustomerFromInput(_ customer : CustomerEntity?) -> APICustomer {
        return APICustomer(
            id: Int(customer?.phone ?? phone)!,
            name: customer?.name ?? name,
            email: customer?.email ?? email,
            gender: customer?.gender ?? gender,
            status: "Active"
        )
    }

    
}
