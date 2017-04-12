//
//  UIViewControllerExtension.swift
//  RSP
//
//  Created by Michael Tan on 12/4/17.
//  Copyright © 2017 exclusivebinary. All rights reserved.
//

import UIKit

extension UIViewController {
    func showLoadingIndicator(_ message: String = "Executing") {
        SwiftSpinner.show(message)
    }
    
    func hideLoadingIndicator() {
        SwiftSpinner.hide()
    }
    
    func showErrorMessage(_ message: String, _ dismissMessage: String = "Tap to hide") {
        SwiftSpinner.show(message, animated: false).addTapHandler({
            SwiftSpinner.hide()
        }, subtitle: dismissMessage)
    }
}
