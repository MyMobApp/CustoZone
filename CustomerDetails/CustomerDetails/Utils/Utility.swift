//
//  Utility.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 13/06/25.
//
import SwiftUI

final class Utility : NSObject{
    
    
    
    static func formatDoubleValue(_ value : Double?) -> String {
        
        if let value = value{
            return String(format: "%.2f", value)
            
        }
        
        return "0.0"
    }
    
}
