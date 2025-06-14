//
//  SplashViewModel.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 14/06/25.
//

import SwiftUI

class SplashViewModel: ObservableObject {
    @Published var isSplashActive = true
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isSplashActive = false
        }
    }
}
