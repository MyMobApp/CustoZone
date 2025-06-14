//
//  NoDataFoundView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 13/06/25.
//

import SwiftUI

struct NoDataFoundView: View {
    
    var imageName : String
    var title : String
    var subTitle : String
    var width = 50
    var height = 50
    var titleFont : Font = .headline
    var subTitleFont : Font = .subheadline
    
    var body: some View {
        VStack(alignment:.center){
            
            Image(systemName: imageName)
                .resizable()
                .frame(width: CGFloat(width),height: CGFloat(height))
                .foregroundStyle(.gray.opacity(0.6))
            Text(title)
                .font(titleFont)
                .foregroundStyle(.gray)
            Text(subTitle)
                .font(subTitleFont)
                .foregroundStyle(.gray)
            
        }.frame(maxWidth: .infinity)
        
    }
}

#Preview {
    NoDataFoundView(imageName: "person.2.fill", title: "No customer records are available", subTitle: "Press '+' button to create")
}
