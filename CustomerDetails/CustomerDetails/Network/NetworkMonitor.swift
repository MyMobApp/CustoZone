//
//  NetworkMonitor.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 14/06/25.
//

import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private(set) var isConnected: Bool = false
    private var isStarted = false
    
    private init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
                if !self.isStarted {
                    self.isStarted = true
                    self.networkStatusUpdated()
                }
            }
        }
        monitor.start(queue: queue)
    }

    var networkStatusUpdated: (() -> Void) = {}

    func checkConnection() -> Bool {
        return isConnected
       
    }
}


