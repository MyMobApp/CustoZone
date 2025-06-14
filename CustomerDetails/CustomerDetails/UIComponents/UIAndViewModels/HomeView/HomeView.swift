//
//  HomeView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    let context: NSManagedObjectContext
    @StateObject private var viewModel: HomeViewModel
    
    init(context: NSManagedObjectContext) {
        self.context = context
        _viewModel = StateObject(wrappedValue: HomeViewModel(context: context))
    }
    
    
    
    var body: some View {
        VStack(spacing: 0) {
            CurvedBottomBannerView()
            
            VStack(alignment: .leading){
                
                SemiBoldTitleView(title: "New Customers")
                
                if viewModel.customerList.count > 0{
                    
                    let custRows = [GridItem(.fixed(150))]
                    ScrollView(.horizontal,showsIndicators: false){
                        LazyHGrid(rows: custRows, spacing: 16) {
                            ForEach(viewModel.customerList,id: \.self){customer in
                                UserCard(title: customer.name ?? "Unknown", col: .cyan)
                            }
                        }
                    }
                    
                }else{
                    NoDataFoundView(imageName: "person.2.fill", title: "No customer records are available", subTitle: "Press '+' to create",width: 40,height: 35)
                }
                
                SemiBoldTitleView(title: "Top Purchases")
                
                if viewModel.purchaseList.count > 0{
                    
                    let rows = [GridItem(.fixed(120))]
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        LazyHGrid(rows: rows, spacing: 16) {
                            ForEach(viewModel.purchaseList, id: \.self) { purchase in
                                PurchaseCard(imageName: "trophy.fill", title: Utility.formatDoubleValue(purchase.totalCost), subTitle1: "\(purchase.user?.name ?? "Unknown")", subTitle2: "AED")
                            }
                        }
                        .padding()
                    }
                    
                }else{
                    NoDataFoundView(imageName: "creditcard", title: "No purchases yet", subTitle: "Goto 'Sales' to start",width: 40,height: 40)
                }
            }.padding()
            Spacer()
        }
        .ignoresSafeArea(edges: .top) // Keeps banner going edge-to-edge at top
    }
}



#Preview {
    HomeView(context: PersistenceController.shared.container.viewContext)
}





