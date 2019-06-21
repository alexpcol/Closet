//
//  ActionSheet.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

struct ActionSheetPresneter {
    private  init() {}
    
    static let shared = ActionSheetPresneter()
    
    func showActionSheet(actions:[UIAlertAction], title:String?, message:String?, inView view:UIViewController) {
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions
        {
            alertController.addAction(action)
        }
        alertController.addAction(cancelAction)
        view.present(alertController, animated: true, completion: nil)
    }
}
