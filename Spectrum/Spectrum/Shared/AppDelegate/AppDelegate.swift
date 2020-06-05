//
//  AppDelegate.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let serviceDispatcher = ServiceDispatcher(services: [
        RootControllerService(),
    ])

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return serviceDispatcher.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

