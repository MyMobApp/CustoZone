//
//  ProductListHeaderView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 14/06/25.
//

import SwiftUI

struct ProductListHeaderView: View {
    
    var titleImage : String
    var title : String
    var subtitle: String
    
    var body: some View {
        HStack{
            
            Image(systemName: titleImage)
                .resizable()
                .frame(width: 80,height: 80)
                .foregroundStyle(.white)
            
            VStack {
                Text(title)
                    .bold()
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                
                Text(subtitle)
                    .foregroundStyle(.white)
                    .font(.headline)
                
            }
        }
    }
}

#Preview {
    ProductListHeaderView(titleImage: "cart.fill", title: "Manage", subtitle: "your product")
}
