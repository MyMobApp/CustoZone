//
//  CustomerDetailsApp.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI

@main
struct CustomerDetailsApp: App {
    @StateObject private var viewModel = SplashViewModel()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isSplashActive {
                SplashScreenView() 
                    
            } else {
                CustomAnimatedTabView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
