//
//  BottomCurvedShape.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI

struct CurvedBottomBannerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start top-left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        // Top-right corner (straight line)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        // Bottom-right corner (start curve from here)
        // We'll draw a curve from bottom-right to bottom-left
        
        // Move down to bottom-right corner (straight line)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 40))
        
        // Curve from bottom-right to bottom-left
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.maxY - 40),
            control: CGPoint(x: rect.midX, y: rect.maxY + 40)
        )
        
        
        
        // Left bottom line up to top-left (straight line)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        return path
    }
}




#Preview {
    CurvedBottomBannerShape()
}
