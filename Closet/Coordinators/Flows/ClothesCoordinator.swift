//
//  ClothesCoordinator.swift
//  Closet
//
//  Created by chila on 6/15/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class ClothesCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let clothesViewController = ClothesViewController.instantiate(fromStoryboard: "Clothes")
        clothesViewController.title = "Clothes"
        clothesViewController.tabBarItem = UITabBarItem(title: "Clothes", image: UIImage(named: "shirt"), tag: 0)
        clothesViewController.coordinator = self
        clothesViewController.setupView(viewModel: ClotheViewModel())
        navigationController.pushViewController(clothesViewController, animated: false)
    }
    
    func addClothe() {
        let addClotheViewController = AddClotheViewController.instantiate(fromStoryboard: "Clothes")
        addClotheViewController.setupView(viewModel: AddClotheViewMothel())
        navigationController.pushViewController(addClotheViewController, animated: true)
    }
}
