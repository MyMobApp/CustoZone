//
//  RightSideBulgeShapeView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI

struct RightSideBulgeShapeView: View {
    var body: some View {
        
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            // Outward bulge parameters
            let outwardCurveInset: CGFloat = 50
            let outwardCurveControlX = width - 150
            
            Path { path in
                path.move(to: CGPoint(x: width, y: 0))
                path.addQuadCurve(
                    to: CGPoint(x: width - outwardCurveInset - 50, y: height),
                    control: CGPoint(x: outwardCurveControlX, y: height / 2)
                )
                path.addLine(to: CGPoint(x: width, y: height))
                path.closeSubpath()
            }
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color.white.opacity(0.15), Color.white.opacity(0.0)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        //.background(.green)
    }
}


#Preview {
    RightSideBulgeShapeView()
}
