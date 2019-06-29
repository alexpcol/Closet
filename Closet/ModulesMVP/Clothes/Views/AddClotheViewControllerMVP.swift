//
//  AddClotheViewControllerMVP.swift
//  Closet
//
//  Created by chila on 6/29/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class AddClotheViewControllerMVP: GenericFormVC, AddClotheViewable, Storyboarded {
    
    private var presenter: AddClothePresentable!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup(title: String, presenter: AddClothePresentable) {
        self.title = title
        self.presenter = presenter
    }
}
