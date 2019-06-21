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
        let vc = OutfitViewController.instantiate(fromStoryboard: "Outfits")
        vc.title = "Outfits"
         vc.tabBarItem = UITabBarItem(title: "Outfits", image: UIImage(named: "man"), tag: 1)
        vc.coordinator = self
        vc.setupView(viewModel: OutfitViewModel())
        navigationController.pushViewController(vc, animated: false)
    }
    
    func addOutfit() {
        let vc = AddOutfitViewController.instantiate(fromStoryboard: "Outfits")
        vc.setupView(viewModel: AddOutfitViewModel())
        navigationController.pushViewController(vc, animated: true)
    }
}
