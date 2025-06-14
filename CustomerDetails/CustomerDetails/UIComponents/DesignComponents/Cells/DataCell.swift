//
//  DataCell.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 13/06/25.
//

import SwiftUI

struct DataCell: View {
    
    var title1 : String
    var title2 : String
    var title3 : String
    var title4 : String
    var imageBtnName : String
    var selectedPurchase: Purchase? = nil
    
    let onDelete: () -> Void
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                cellText(title1)
                cellText(title2)
                cellText(title3)
                cellText(title4)
                cellIcon(systemName: imageBtnName) {
                    onDelete()
                }
            }
            
            
            Spacer()
        }
    }
    
    
    
    
    
    func cellText(_ text: String) -> some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .font(.system(size: 14))
            .foregroundColor(.black)
            .border(Color.white, width: 1)
    }
    
    func cellIcon(systemName: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }) {
            Image(systemName: systemName)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .contentShape(Rectangle())
        }
        .border(Color.white, width: 1)
    }
    
}


#Preview {
    DataCell(title1: "", title2: "", title3: "", title4: "", imageBtnName: "", onDelete: {})
}
