//
//  ReachabilityManager.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import Network

class ReachabilityManager {
    static var shared = ReachabilityManager()
    
    let monitor = NWPathMonitor()
    var hasConnection = false
    
    func start() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.hasConnection = true
            } else {
                self.hasConnection = false
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
