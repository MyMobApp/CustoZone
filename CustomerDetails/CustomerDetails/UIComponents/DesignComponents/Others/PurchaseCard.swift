//
//  PurchaseCard.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 13/06/25.
//

import SwiftUI

struct PurchaseCard: View {
    
    var imageName : String
    var title : String
    var subTitle1 : String
    var subTitle2 : String
    
    var body: some View {

        
        VStack(spacing:0){
            Spacer()

            
            HStack(spacing:0){
                Image(systemName: imageName)
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 60,height: 60)
                    
                    .padding()
                
                
                VStack(alignment:.leading,spacing:0){
                   
                        Text(title)
                            .fontWeight(.semibold)
                            .font(.system(size: 25))
                            .foregroundStyle(.white)
                            .frame(height: 40)
                        Text(subTitle2)
                            .fontWeight(.semibold)
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(.trailing,20)
                            .bold()
                
                       
                    Text(subTitle1)
                        .foregroundStyle(.white)
                        .frame(height: 20)
                        .bold()
                        
                }
              //  .frame(width: .infinity,height: 60)
                
                
                Spacer()
            }
            //.frame(width: .infinity,height: 80)
                
                
            
            Spacer()
            //[.red,.mint]
            
        }.cornerRadius(10)
            .frame(width: 250,height: 120)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(LinearGradient(colors: [.blue,.mint], startPoint: .topLeading, endPoint: .bottomTrailing))
            ).overlay(content: {
                
            }).shadow(color: .gray.opacity(0.4), radius: 6, x: 0, y: 10)
  
        
    }
}

#Preview {
    PurchaseCard(imageName: "trophy.fill", title: "788.12", subTitle1: "Mahesh", subTitle2: "AED")
}
