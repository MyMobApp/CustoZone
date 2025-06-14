//
//  CustomerListViewCell.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI
import CoreData

struct CustomerListViewCell: View {
    var title : String
    var subTitle : String
    var purchaseCount : String
    var profileImageName : String
    let context : NSManagedObjectContext
    var selectedCustomer: CustomerEntity? = nil
    var selectedProduct: ProductEntity? = nil
    let onDelete: () -> Void
    @State private var isUpdate = false
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.blue]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 130)
                .shadow(color: .gray.opacity(0.4), radius: 6, x: 0, y: 10)
                .padding()
            
            RightSideBulgeShapeView()
                .frame(height: 110)
                .padding()
            
            VStack{
                HStack{
                    Image(profileImageName)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white).padding()
                    VStack(alignment: .leading,spacing: 4){
                        Text(title)
                            .fontWeight(.semibold)
                            .font(.title2)
                            .foregroundStyle(.white)
                        Text(subTitle)
                        
                            .font(.subheadline)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    
                    VStack(alignment: .center){
                        Text(purchaseCount)
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        Text("Puchase")
                        
                            .font(.subheadline)
                            .foregroundStyle(.white)
                    }.padding()
                    
                    
                    
                }.padding()
                    .frame(height: 80)
                //  .background(.gray)
                
                HStack(spacing:20){
                    Spacer()
                    Button(action: {
                        
                        isUpdate = true
                        
                        
                        print("Image button tapped")
                    }) {
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        onDelete()
                        print("Image button tapped")
                    }) {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                    
                    
                }.padding(.trailing,30)
                    .navigationDestination(isPresented: $isUpdate) {
                        
                        if let _ = selectedCustomer{
                            AddOrUpdateUserDetailsView(context: context,customerToEdit: selectedCustomer, isUpdate: $isUpdate)
                        }
                        
                        if let _ = selectedProduct{
                            AddProductView(context: context, productToEdit: selectedProduct, isUpdate: $isUpdate)
                        }
                        
                    }
            }
        }
        
    }
}


#Preview {
    CustomerListViewCell(
        title: "Jane Smith",
        subTitle: "Gold Member",
        purchaseCount: "8",
        profileImageName: "profileMale", context: PersistenceController.shared.container.viewContext, onDelete: {}
        
    )
}
