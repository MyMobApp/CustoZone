//
//  UserListView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI
import CoreData

struct UserListView: View {
    
    let context: NSManagedObjectContext
    @StateObject private var viewModel: UserListViewModel
    @State var selectedCustomer: CustomerEntity? = nil
    
    init(context: NSManagedObjectContext) {
        self.context = context
        _viewModel = StateObject(wrappedValue: UserListViewModel(context: context))
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                if viewModel.customers.count > 0{
                    
                    VStack(spacing: 0) {
                        ForEach(viewModel.customers, id: \.self) { customer in
                            CustomerListViewCell(
                                title: customer.name ?? "Unknown",
                                subTitle: "Ph: \(customer.phone ?? "N/A")",
                                purchaseCount: "\(customer.purchases?.count ?? 0)",
                                profileImageName: customer.gender == "Female" ? "profileFemale" : "profileMale",context: context,
                                selectedCustomer :customer,
                                onDelete: {
                                    deleteCustomerRecords(customer)
                                }
                            )
                        }
                    }
                    .padding()
                }else{
                    NoDataFoundView(imageName: "person.2.fill", title: "No customer records are available", subTitle: "Press '+' to create",width: 40,height: 35).padding(.top,250)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    ToolbarHeaderView(imageName: "person.3.fill", title: "User List")
                }
            }
            .toolbarBackground(Color.blue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("reloadUserData"))) { _ in
                viewModel.fetchCustomers()
            }
            
        }
    }
    
    func deleteCustomerRecords(_ customer : CustomerEntity){
        
        Task{
            do{
                guard NetworkMonitor.shared.checkConnection() else {
                    print("No network connection available.")
                    return
                }
                
                
                if let id = Int(customer.phone!) {
                    try await APIService.shared.deleteCustomer(id: id)
                } else {}
                viewModel.deleteCustomer(customer)
                NotificationCenter.default.post(name: Notification.Name("reloadUserData"), object: nil)
                
            } catch {
                viewModel.deleteCustomer(customer)
                NotificationCenter.default.post(name: Notification.Name("reloadUserData"), object: nil)
                print("API Deletion Error: \(error.localizedDescription)")
                
            }
        }
    }
    
}


#Preview {
    UserListView(context: PersistenceController.shared.container.viewContext)
}
