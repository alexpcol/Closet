//
//  AlertHeaderModel.swift
//  Closet
//
//  Created by chila on 6/22/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

enum AlertActions: String {
    case ok
    case cancel
}

struct AlertHeaderModel {
    let title: String
    let message: String
    let alertAction: AlertActions?
    let action: (() -> Void)?
    
    init(title: String, message: String, alertAction: AlertActions? = nil, action: (() -> Void)? = nil) {
        self.title = title
        self.message = message
        self.alertAction = alertAction
        self.action = action
    }
}
