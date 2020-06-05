//
//  ApplicationCoordinator.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    static let shared = ApplicationCoordinator()
    
    let window: UIWindow
    let rootViewController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        rootViewController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        showCompanyList()
    }
}

extension ApplicationCoordinator {
    func showCompanyList() {
        removeAllChildCoordinator()
        let companyListCoordinator = CompanyListCoordinator(presenter: rootViewController, window: window)
        appendChildCoordinator(companyListCoordinator)
        companyListCoordinator.parentCoordinator = self
        companyListCoordinator.start()
    }
}
