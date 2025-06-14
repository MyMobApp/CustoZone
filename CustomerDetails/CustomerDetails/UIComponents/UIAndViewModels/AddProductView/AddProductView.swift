//
//  AddProductView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI
import CoreData




struct AddProductView: View {
    
    @Binding var isUpdate: Bool
    let productToEdit: ProductEntity?
    @StateObject private var viewModel: AddProductViewModel
    
    
    // MARK: - Core Data Fetches
    
    init(context: NSManagedObjectContext, productToEdit: ProductEntity?, isUpdate: Binding<Bool>) {
        self.productToEdit = productToEdit
        _isUpdate = isUpdate
        _viewModel = StateObject(wrappedValue: AddProductViewModel(context: context, product: productToEdit))
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                Spacer(minLength: 30)
                VStack(alignment: .leading, spacing: 20) {
                    
                    Group {
                        InputField(title: "Product name", text: $viewModel.productName, icon: "bag")
                        InputField(title: "Cost", text: $viewModel.costText, icon: "creditcard", keyboard: .decimalPad, autoCapital: .none)
                        Spacer(minLength: 5)
                        
                        Button(action: {
                 
                            if viewModel.isNewProduct(productToEdit != nil){
                                viewModel.saveProduct(isUpdate, productToEdit: productToEdit)
                                isUpdate = false
                                NotificationCenter.default.post(name: Notification.Name("reloadProductData"), object: nil)
                            }
                            
                        }) {
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                Text(productToEdit != nil ? "Update product" : "Add product")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(colors: [Color.blue, Color.mint], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(12)
                            .shadow(radius: 10)
                        }
                        
                        
                    }
                }
                .padding()
                .alert("Info", isPresented: $viewModel.showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(viewModel.alertMessage)
                }
                
            }.toolbar {
                ToolbarItem(placement: .navigation) {
                    ToolbarHeaderView(imageName: "shippingbox", title: productToEdit != nil ? "Update Items" : "Add Items")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isUpdate = false
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
    AddProductView(context: PersistenceController.shared.container.viewContext, productToEdit: nil, isUpdate: .constant(false))
}
