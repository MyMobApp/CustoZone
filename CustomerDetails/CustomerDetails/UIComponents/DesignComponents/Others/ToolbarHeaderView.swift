//
//  ToolbarHeaderView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 14/06/25.
//

import SwiftUI

struct ToolbarHeaderView: View {
    var imageName : String
    var title : String
    
    var body: some View {
        HStack(spacing: 6) {
            if imageName.count > 0{
                Image(systemName: imageName)
                    .foregroundColor(.white)
            }
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
        }
        
    }
    
}

#Preview {
    ToolbarHeaderView(imageName: "person.3.fill", title: "User List")
}
