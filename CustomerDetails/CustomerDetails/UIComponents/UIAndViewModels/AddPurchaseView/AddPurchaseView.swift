//
//  AddPurchaseView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 13/06/25.
//

import SwiftUI
import CoreData

struct AddPurchaseView: View {
    
    @StateObject private var viewModel: AddPurchaseViewModel
    @State private var isPurchaseListOpen = false
    // MARK: - Core Data Fetches
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        _viewModel = StateObject(wrappedValue: AddPurchaseViewModel(context: context))
        
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Date
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Purchase Date", systemImage: "calendar")
                            .font(.caption)
                            .foregroundStyle(.blue)
                        DatePicker("Select Date", selection: $viewModel.purchaseDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }
                    
                    // Total Cost
                    VStack(alignment: .leading, spacing: 8) {
                        
                        InputField(title: "Total cost", text: $viewModel.totalCostText, icon: "creditcard").onChange(of: viewModel.totalCostText) { newValue in
                            viewModel.totalCostText = newValue.filter { "0123456789.".contains($0) }
                        }.frame(height: 60)
                        
                            .disabled(true)
                        
                    }.onTapGesture {
                        viewModel.isCostTextTapped()
                    }
                    
                    // User Picker
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Select Customer")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.leading, 4)
                        
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.blue)
                            
                            Picker(selection: $viewModel.selectedUser, label: Text("")) {
                                ForEach(viewModel.customers, id: \.self) { user in
                                    Text(user.name ?? "Unnamed")
                                        .tag(user as CustomerEntity?)
                                }
                            }
                            .pickerStyle(.menu)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(UIColor.secondarySystemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondary.opacity(0.3))
                        )
                    }
                    .padding(.vertical, 5)
                    .onTapGesture {
                        if viewModel.customers.count == 0{
                            viewModel.isCustomerTextTapped()
                        }
                    }
                    
                    
                    
                    // Product Multi-Select
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Select products", systemImage: "cart.fill")
                            .font(.caption)
                            .foregroundColor(.blue)
                        ForEach(viewModel.products, id: \.self) { product in
                            MultipleSelectionRow(title: product.productName ?? "Unnamed", isSelected: viewModel.selectedProducts.contains(product)) {
                                if viewModel.selectedProducts.contains(product) {
                                    viewModel.selectedProducts.remove(product)
                                    viewModel.totalCost -= product.cost
                                } else {
                                    viewModel.selectedProducts.insert(product)
                                    viewModel.totalCost += product.cost
                                }
                                viewModel.updateTotalCostText()
                            }
                        }
                        .padding(.vertical, 4)
                        
                    }.onTapGesture {
                        if viewModel.products.count == 0{
                            viewModel.isProcuctTextTapped()
                        }
                    }
                    
                    
                    // Submit Button
                    Button(action: viewModel.savePurchase) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Submit Purchase")
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
                .padding()
                .alert("Info", isPresented: $viewModel.showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(viewModel.alertMessage)
                }
            }.toolbar {
                
                ToolbarItem(placement: .navigation) {
                    ToolbarHeaderView(imageName: "creditcard", title: "New Purchase")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPurchaseListOpen = true
                    }) {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.white)
                    }
                }
            }
            .toolbarBackground(Color.blue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationDestination(isPresented: $isPurchaseListOpen) {
                
                PurchaseListView(context: context, isPurchaseListOpen: $isPurchaseListOpen)
                
            }
        }
    }
    
}


#Preview {
    AddPurchaseView(context: PersistenceController.shared.container.viewContext)
}
