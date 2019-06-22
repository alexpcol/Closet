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
        let outfitViewController = OutfitViewController.instantiate(fromStoryboard: "Outfits")
        outfitViewController.title = "Outfits"
         outfitViewController.tabBarItem = UITabBarItem(title: "Outfits", image: UIImage(named: "man"), tag: 1)
        outfitViewController.coordinator = self
        outfitViewController.setupView(viewModel: OutfitViewModel())
        navigationController.pushViewController(outfitViewController, animated: false)
    }
    
    func addOutfit() {
        let addOutfitViewController = AddOutfitViewController.instantiate(fromStoryboard: "Outfits")
        addOutfitViewController.coordinator = self
        addOutfitViewController.setupView(viewModel: AddOutfitViewModel())
        navigationController.pushViewController(addOutfitViewController, animated: true)
    }
    
    func pickClothe(in view: ClothePicked, withPiece piece: PieceType) {
        let pickClothePieceTypeViewController = PickClothePieceTypeViewController.instantiate(fromStoryboard: "Outfits")
        let navigationController = UINavigationController(rootViewController: pickClothePieceTypeViewController)
        pickClothePieceTypeViewController.delegate = view
        pickClothePieceTypeViewController.setupView(viewModel: PickClothePieceTypeViewModel(piece: piece))
        self.navigationController.present(navigationController, animated: true)
    }
}
