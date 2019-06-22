//
//  Alerts.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//
import UIKit

struct AlertsPresenter {
    
    private init() {}
    static let shared = AlertsPresenter()
    
    func showOKAlert(title:String, message:String, inView view:UIViewController) {
        let okAction = UIAlertAction(title: "OK", style: .default) { (alert) in }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(okAction)
        view.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithAction(alertTitle: String,
                                    alertMessage: String,
                                    actionTitle: String,
                                    actionStyle: UIAlertAction.Style,
                                    inView view:UIViewController,
                                    completion: @escaping()-> Void) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alertController.addAction(cancelAction)
        let action = UIAlertAction(title: actionTitle, style: actionStyle) { (_) in
            completion()
        }
        alertController.addAction(action)
        alertController.preferredAction = action
        view.present(alertController, animated: true)
    }
    
    func showActionSheet(actions:[UIAlertAction],
                                title:String?,
                                message:String?,
                                inView view:UIViewController) {
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "nil"), style: .cancel)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions {
            alertController.addAction(action)
        }
        alertController.addAction(cancelAction)
        view.present(alertController, animated: true, completion: nil)
    }
}
