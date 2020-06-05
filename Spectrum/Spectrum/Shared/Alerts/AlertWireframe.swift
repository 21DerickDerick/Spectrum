//
//  AlertWireframe.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit

class AlertWireframe {
    static var shared = AlertWireframe()

    func showOneButtonAlert(_ title: String?, message: String?, actionButton: String, inViewController viewController: UIViewController?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionButton = UIAlertAction(title: actionButton, style: .default, handler: nil)
        alertController.addAction(actionButton)
        viewController?.present(alertController, animated: true, completion: nil)
    }
}
