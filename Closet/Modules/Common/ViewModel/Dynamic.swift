//
//  Dynamic.swift
//  Closet
//
//  Created by chila on 6/20/19.
//  Copyright © 2019 chila. All rights reserved.
//

import Foundation

/// Use this class for properties in ViewModels that we expect to change during the View lifecycle.
class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
