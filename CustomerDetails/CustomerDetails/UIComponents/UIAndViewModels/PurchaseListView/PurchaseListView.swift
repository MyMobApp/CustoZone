//
//  PurchaseListView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI
import CoreData

struct PurchaseListView: View {
    
    let context: NSManagedObjectContext
    
    @StateObject private var viewModel: PurchaseListViewModel
    @State var selectedCustomer: Purchase? = nil
    @Binding var isPurchaseListOpen : Bool
    
    init(context: NSManagedObjectContext,isPurchaseListOpen : Binding<Bool>) {
        self.context = context
        _isPurchaseListOpen = isPurchaseListOpen
        _viewModel = StateObject(wrappedValue: PurchaseListViewModel(context: context))
    }
    
    
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    if viewModel.purchaseList.count > 0{
                        
                        HeaderView(title1: "Date", title2: "Name", title3: "Cost", title4: "Items")
                        ForEach(viewModel.purchaseList, id: \.self) { purchase in
                            
                            DataCell(title1: viewModel.formatDate(purchase.purchaseDate ?? Date()),
                                     title2: purchase.user?.name ?? "Unknown",
                                     title3: "\(purchase.totalCost)",
                                     title4: "\(purchase.products?.allObjects.count ?? 0)",
                                     imageBtnName: "trash",
                                     selectedPurchase: purchase) {
                                viewModel.deleteCustomer(purchase)
                            }
                        }
                        
                        Spacer()
                        
                    }else{
                        
                        NoDataFoundView(imageName: "cart", title: "No purchase details are available", subTitle: "Let's create new purchase recors").padding(.top,250)
                    }
                }
                .padding(2)
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    ToolbarHeaderView(imageName: "", title: "Purchase List")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isPurchaseListOpen = false
                    }) {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.white)
                    }
                }
            }
            .toolbarBackground(Color.blue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}


#Preview {
    PurchaseListView(context: PersistenceController.shared.container.viewContext, isPurchaseListOpen: .constant(false))
}
