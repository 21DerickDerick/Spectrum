//
//  Coordinator.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import Foundation

@objc protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    @objc optional func start()
}

extension Coordinator {
    
    func appendChildCoordinator(_ child: Coordinator) {
        childCoordinators.append(child)
    }
    
    func removeAllChildCoordinator() {
        childCoordinators.removeAll()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func traverseChildCoordinators() -> [Coordinator] {
        var coordinators = [Coordinator]()
        
        for coor in childCoordinators {
            coordinators.append(coor)
            coordinators += coor.traverseChildCoordinators()
        }
        return coordinators
    }
}
