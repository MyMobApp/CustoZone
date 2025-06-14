//
//  ProductListView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI
import CoreData

struct ProductListView: View {
    
    @StateObject private var viewModel: ProductListViewModel
    @State var selectedProduct: ProductEntity? = nil
    
    let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
        _viewModel = StateObject(wrappedValue: ProductListViewModel(context: context))
    }
    

    
    var body: some View {
        
        NavigationStack {
            
                ZStack(alignment: .topTrailing) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill( LinearGradient(colors: [.blue,.mint], startPoint: .leading, endPoint: .trailing))
                        .frame(height: 150)
                        .padding()
                        .overlay(content: {
                            
                            ProductListHeaderView(titleImage: "cart.fill", title: "Manage", subtitle: "your stock")
                            
                            
                        })
                    
                    Button{
                        viewModel.showAddProduct = true
                    }label: {
                        Text("Add")
                            .fontWeight(.semibold)
                    }.frame(width: 60,height: 30)
                        .background(.black)
                        .foregroundStyle(.white)
                        .cornerRadius(25)
                        .padding(.top,25)
                        .padding(.trailing,25)
                    
                }
                .navigationDestination(isPresented: $viewModel.showAddProduct) {
                    AddProductView(context: context, productToEdit: selectedProduct, isUpdate: $viewModel.showAddProduct)
                }
            
                
            ScrollView {
                SemiBoldTitleView(title: "Product List")
 
                if viewModel.products.count > 0{
                    
                    VStack(spacing: 0) {
                        ForEach(viewModel.products, id: \.self) { product in
                            CustomerListViewCell(
                                title: product.productName ?? "Unknown",
                                subTitle: "SKU 100B11",
                                purchaseCount: "\(product.cost)",
                                profileImageName: "cart",context: context,
                                selectedProduct: product,
                                onDelete: { viewModel.deleteProduct(product) }
                            )
                        }
                    }
                    .padding()
                }else{
                    
                    NoDataFoundView(imageName: "cart", title: "No products details are available", subTitle: "Press 'Add' to create").padding(.top,100)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    ToolbarHeaderView(imageName: "shippingbox", title: "Add Products")
                   
                }
            }
            .toolbarBackground(Color.blue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("reloadProductData"))) { _ in
                viewModel.fetchProducts()
            }
        }
    }
}

#Preview {
    ProductListView(context: PersistenceController.shared.container.viewContext)
}


