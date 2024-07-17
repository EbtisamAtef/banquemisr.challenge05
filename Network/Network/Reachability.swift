//
//  Reachability.swift
//  Network
//
//  Created by mac on 16/07/2024.
//

import Foundation
import Network


struct Internet {
    
    private static let monitor = NWPathMonitor()
    
    static var active = false
    static var expensive = false
    
    static func start() {
        guard monitor.pathUpdateHandler == nil else { return }
        
        monitor.pathUpdateHandler = { update in
            Internet.active = update.status == .satisfied ? true : false
            Internet.expensive = update.isExpensive ? true : false
        }
        
        monitor.start(queue: DispatchQueue(label: "InternetMonitor"))
    }
    
}
