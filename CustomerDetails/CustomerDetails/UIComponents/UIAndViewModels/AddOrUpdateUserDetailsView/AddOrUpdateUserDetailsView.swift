//
//  AddOrUpdateUserDetailsView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI
import CoreData

    struct AddOrUpdateUserDetailsView: View {
        // MARK: - State Variables
     
        let customerToEdit: CustomerEntity?
        @StateObject private var viewModel: AddOrUpdateUserDetailsViewModel
        @Binding var isUpdate: Bool
        @State private var errorMessage = ""
        

        // MARK: - Core Data Fetches
        
        init(context: NSManagedObjectContext, customerToEdit: CustomerEntity?, isUpdate: Binding<Bool>) {
            self.customerToEdit = customerToEdit
            _isUpdate = isUpdate
            _viewModel = StateObject(wrappedValue: AddOrUpdateUserDetailsViewModel(context: context, customer: customerToEdit))
        }
        
        // Gender options
        private let genderOptions = ["Male", "Female"]

        var body: some View {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Group {
                            InputField(title: "Full Name", text: $viewModel.name, icon: "person.fill")
                            InputField(title: "Email", text: $viewModel.email, icon: "envelope.fill", keyboard: .emailAddress, autoCapital: .none)
                            InputField(title: "Phone", text: $viewModel.phone, icon: "phone.fill", keyboard: .numberPad)
                            InputField(title: "Address", text: $viewModel.address, icon: "house.fill")
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Label("Date of Birth", systemImage: "calendar")
                                .font(.caption)
                                .foregroundColor(.blue)
                            DatePicker("Select Date", selection: $viewModel.dob, displayedComponents: .date)
                                .datePickerStyle(.compact)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 6) {
                                Image(systemName: "person.2.fill")
                                    .foregroundColor(.blue)
                                Text("Gender")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Picker("", selection: $viewModel.gender) {
                                ForEach(genderOptions, id: \.self) { option in
                                    Text(option).tag(option)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding(.vertical, 6)
                            .tint(.blue)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(UIColor.secondarySystemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                        )


                        //Spacer(minLength: 30)

                        Button(action: {
                            
                            saveOrUpdateRecords()
                            
                            
                        }) {
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                Text(isUpdate ? "Update" : "Submit")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(colors: [Color.blue, Color.mint], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(12)
                            .shadow(radius: 10)
                        }.alert("Info", isPresented: $viewModel.showAlert) {
                            Button("OK", role: .cancel) { }
                        } message: {
                            Text(viewModel.alertMessage)
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
                        
                        ToolbarHeaderView(imageName: "person.circle", title: isUpdate ? "Edit Details" : "Add Customer")
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Button{
                            saveOrUpdateRecords()
                        }label: {
                            Text(isUpdate ? "Update" : "Save")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        
                    }
                }
                
                .toolbarBackground(Color.blue, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                //.navigationTitle("New User")
            }
        }
        
        
        
        func saveOrUpdateRecords() {
            
            viewModel.validateUserInput(viewModel.name, viewModel.email, viewModel.phone, viewModel.address, viewModel.dob, viewModel.gender)
            
            if viewModel.showAlert {
                return
            }
            
            Task {
                do {

                    guard NetworkMonitor.shared.checkConnection() else {
                        print("No network connection available.")
                        return
                    }
                    
                    let apiCustomer = viewModel.buildAPICustomerFromInput(customerToEdit)
                    
                    if isUpdate {
                        _ = try await APIService.shared.updateCustomer(apiCustomer)
                    } else {
                        _ = try await APIService.shared.createCustomer(apiCustomer)
                    }
                    
                    viewModel.saveUser(isUpdate, customerToEdit: customerToEdit)
                    isUpdate = false
                    NotificationCenter.default.post(name: Notification.Name("reloadUserData"), object: nil)
                    
                } catch {
                    print("API Error: \(error.localizedDescription)")
                    viewModel.saveUser(isUpdate, customerToEdit: customerToEdit)
                    isUpdate = false
                    NotificationCenter.default.post(name: Notification.Name("reloadUserData"), object: nil)
                }
                
            }
        }

    }



#Preview {
    AddOrUpdateUserDetailsView(context: PersistenceController.shared.container.viewContext, customerToEdit: nil, isUpdate: .constant(false))
}


