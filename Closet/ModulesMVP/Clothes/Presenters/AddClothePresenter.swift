//
//  AddClothePresenter.swift
//  Closet
//
//  Created by chila on 6/29/19.
//  Copyright © 2019 chila. All rights reserved.
//

import Foundation

class AddClothePresenter: AddClothePresentable {
    func startEditing(property: ClotheProperties) {
        print("Hello")
    }
    
    func didSelectAddImge() {
        print("goodbye")
    }
    
    private weak var view: AddClotheViewable?
    
    init() {
    }
    
    func attach(view: AddClotheViewable) {
        self.view = view
        self.view?.setup(title: "New", presenter: self as AddClothePresentable)
    }
}
