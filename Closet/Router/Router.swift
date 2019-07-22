//
//  Coordinator.swift
//  Closet
//
//  Created by chila on 6/15/19.
//  Copyright © 2019 chila. All rights reserved.
//

import Foundation
import UIKit

protocol Router: AnyObject {
    var childRouters: [Router] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
    func returnToPreviousView()
}

extension Router {
    func returnToPreviousView() {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: true)
        } else {
            navigationController.popViewController(animated: true)
        }
    }
}
