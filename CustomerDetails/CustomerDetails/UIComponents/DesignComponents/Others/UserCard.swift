//
//  UserCard.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI

struct UserCard: View {
    
    var title : String
    var col : Color
    
    var body: some View {
        //Rectangle()
        RoundedRectangle(cornerRadius: 10)
            .fill(col.opacity(0.2))
            .frame(width: 110,height: 125)
            .overlay{
                VStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 50,height: 50)
                        .foregroundStyle(col)
                    Text(title.split(separator: " ").first ?? "")
                        .multilineTextAlignment(.center)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .font(.subheadline)
                    
                }
            }.shadow(color: .gray.opacity(0.4), radius: 6, x: 0, y: 10)
    }
}

#Preview {
    UserCard(title: "Name", col: .green)
}
