//
//  ClotheViewControllerMVP.swift
//  Closet
//
//  Created by chila on 6/29/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class ClotheViewControllerMVP: UIViewController, ClotheViewable, Storyboarded {
    
    private var presenter: ClothePresentable!
    private var addButtonAction:(() -> Void)?
    
    func showAddButton(action: @escaping () -> Void) {
        addButtonAction = action
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItems = [addButtonItem]
    }
    
    func setup(title: String, presenter: ClothePresentable) {
        self.title = title
        self.presenter = presenter
    }
    
    func setSection(icon: String, title: String) {
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(named: icon), tag: 0)
    }
    
    @objc private func didTapAddButton() {
        addButtonAction?()
    }
}
