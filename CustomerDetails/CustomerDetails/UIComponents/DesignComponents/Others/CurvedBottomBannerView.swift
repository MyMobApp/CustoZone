//
//  CurvedBottomBannerView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 13/06/25.
//

import SwiftUI

struct CurvedBottomBannerView: View {
    var body: some View {
        ZStack(alignment: .top) {
            // Banner at bottom layer
            CurvedBottomBannerShape()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color("MColor")]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 250)
                .shadow(radius: 5)
            
            VStack{
                Text("CustoZone")
                    .bold()
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 20)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                
                //  HStack(alignment:.top ,spacing:10){
                VStack(alignment: .leading) {
                    Text("Know your customers Track their journey")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.top,10).multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    Text("All in one place")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                    //.padding(.top,10)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    
                    
                }
            }
        }
    }
}


#Preview {
    CurvedBottomBannerView()
}
