//
//  PresentsAlert.swift
//  The Weather App
//
//  Created by Sajjad on 01/04/2020.
//  Copyright © 2020 The Weather App. All rights reserved.
//

import Foundation
import UIKit

/// Alert Response Type
enum AlertResponse{
    case ok, cancel
}

/// Configuration of an Alert
typealias AlertConfiguration = (
    title :String?,
    message :String?,
    okButtonTitle :String?,
    cancelButtonTitle :String?
)

/// Protocol that presents Alter on Screen
protocol PresentsAlert {
    func presentAlert(config: AlertConfiguration, response: ((_ dismissedWithCancel: AlertResponse) -> Void)?)
}

extension PresentsAlert where Self : UIViewController {
    /// generic alert method for creating and presenting UIAlertViewController with two buttons
    /// - Parameters:
    ///   - config: Configuration of UIAlertViewController
    ///   - response: closure with enum of the Type alertResponse, if okay button is pressed response will have .OK key. If cancel button is pressed it will have .Cancel key.
    func presentAlert(config: AlertConfiguration, response: ((_ dismissedWithCancel: AlertResponse) -> Void)?) {
        let alertController: UIAlertController = UIAlertController(title: config.title,
                                                                   message: config.message,
                                                                   preferredStyle: .alert)
        defer {
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        func createAction(title: String?, style: UIAlertAction.Style, type: AlertResponse) -> UIAlertAction {
            let action = UIAlertAction(title: title, style: style, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
                if let response = response {
                    response(type)
                }
            })
            return action
        }
        
        alertController.addAction(createAction(title: config.okButtonTitle, style: .default, type: .ok))
        guard let cancelTitle = config.cancelButtonTitle else { return }
        alertController.addAction(createAction(title: cancelTitle, style: .cancel, type: .cancel))
    }
}
