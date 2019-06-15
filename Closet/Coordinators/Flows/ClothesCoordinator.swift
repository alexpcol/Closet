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
        let vc = ClothesViewController.instantiate()
        vc.title = "Clothes"
        vc.tabBarItem = UITabBarItem(title: "Clothes", image: UIImage(named: "shirt"), tag: 0)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
