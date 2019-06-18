//
//  CoreDataContainer.swift
//  Closet
//
//  Created by chila on 6/12/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit
import CoreData

extension UIApplication {
    static var container: NSPersistentContainer {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
}
