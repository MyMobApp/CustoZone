//
//  SemiBoldTitleView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 13/06/25.
//

import SwiftUI

struct SemiBoldTitleView: View {
    var title : String
    var body: some View {
        Text(title)
            .fontWeight(.semibold)
            .font(.title3)
        
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading).padding()
    }
}



#Preview {
    SemiBoldTitleView(title: "Title")
}
