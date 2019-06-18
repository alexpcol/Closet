//
//  StorryboardExtension.swift
//  Closet
//
//  Created by chila on 6/15/19.
//  Copyright © 2019 chila. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate(fromStoryboard nibName: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(fromStoryboard nibName: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: nibName, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
