//
//  HeaderView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 13/06/25.
//

import SwiftUI

struct HeaderView: View {
    
    var title1 : String
    var title2 : String
    var title3 : String
    var title4 : String
    
    var body: some View {
        VStack(spacing: 0) {
            // Header Row
            HStack(spacing: 0) {
                headerText(title1)
                headerText(title2)
                headerText(title3)
                headerText(title4)
                headerText(" ")
            }
            .background(Color.blue)
        }
    }
    
    func headerText(_ text: String) -> some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .font(.headline)
            .foregroundColor(.white)
            .border(Color.white, width: 1)
    }
}

#Preview {
    HeaderView(title1: "", title2: "", title3: "", title4: "")
}
