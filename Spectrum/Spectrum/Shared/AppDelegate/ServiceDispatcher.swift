//
//  ServiceDispatcher.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit

class ServiceDispatcher: UIResponder, UIApplicationDelegate {
    let services: [UIApplicationDelegate]
    init(services: [UIApplicationDelegate]) {
        self.services = services
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        services.forEach { service in
            let _ = service.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        
        return true
    }
}
