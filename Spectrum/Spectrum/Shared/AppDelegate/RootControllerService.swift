//
//  RootControllerService.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class RootControllerService: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        ApplicationCoordinator.shared.start()
        ReachabilityManager.shared.start()
        
        IQKeyboardManager.shared.enable = true
        
        return true
    }
}
