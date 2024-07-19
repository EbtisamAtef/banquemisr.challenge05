//
//  Reachability.swift
//  Network
//
//  Created by mac on 16/07/2024.
//

import Foundation
import Network

public class Reachability {
    
    public struct NetworkStatus {
        public var isConnected: Bool
        public var isExpensive: Bool
    }
    
    public static func checkNetworkConnectivity() async -> NetworkStatus {
        return await withCheckedContinuation { continuation in
            let monitor = NWPathMonitor()
            let queue = DispatchQueue.global(qos: .background)
            
            monitor.pathUpdateHandler = { path in
                let status = NetworkStatus(isConnected: path.status == .satisfied, isExpensive: path.isExpensive)
                continuation.resume(returning: status)
                monitor.cancel()
            }
            
            monitor.start(queue: queue)
        }
    }
    
}
