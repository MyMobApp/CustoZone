//
//  CustomerListView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 14/06/25.
//

import SwiftUI
import CoreData

struct CustomerListView: View {
    
    var viewModel : UserListViewModel
    var context : NSManagedObjectContext
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.customers, id: \.self) { customer in
                CustomerListViewCell(
                    title: customer.name ?? "Unknown",
                    subTitle: "Ph: \(customer.phone ?? "N/A")",
                    purchaseCount: "\(customer.purchases?.count ?? 0)",
                    profileImageName: customer.gender == "Female" ? "profileFemale" : "profileMale",context: context,
                    selectedCustomer :customer,
                    onDelete: { viewModel.deleteCustomer(customer) }
                )
            }
        }
        .padding()
    }
}

#Preview {
  //  CustomerListView(viewModel: StateObject(wrappedValue: UserListViewModel(context: PersistenceController.shared.container.viewContext)), context: PersistenceController.shared.container.viewContext)
}
