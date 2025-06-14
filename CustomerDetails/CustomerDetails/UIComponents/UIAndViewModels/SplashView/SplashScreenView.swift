//
//  SplashScreenView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 14/06/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var scaleTitle: CGFloat = 1.0
    
    var body: some View {
        ZStack {
           
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.mint]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
           
            Text("CustoZone")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .scaleEffect(scaleTitle)
                .onAppear {
                    withAnimation(.easeOut(duration: 1.5).delay(0.2)) {
                        scaleTitle = 1.2
                    }
                }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
