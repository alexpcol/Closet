//
//  OutfitsCoordinator.swift
//  Closet
//
//  Created by chila on 6/15/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class OutfitsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = OutfitViewController.instantiate()
        vc.title = "Outfits"
         vc.tabBarItem = UITabBarItem(title: "Clothes", image: UIImage(named: "man"), tag: 1)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
