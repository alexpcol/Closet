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
    
    //MARK:-  MVVM Methods
//    func start() {
//        let clothesViewController = ClothesViewController.instantiate(fromStoryboard: "Clothes")
//        clothesViewController.title = "Clothes"
//        clothesViewController.tabBarItem = UITabBarItem(title: "Clothes", image: UIImage(named: "shirt"), tag: 0)
//        clothesViewController.coordinator = self
//        clothesViewController.setupView(viewModel: ClotheViewModel())
//        navigationController.pushViewController(clothesViewController, animated: false)
//    }
//
//    func addClothe() {
//        let addClotheViewController = AddClotheViewController.instantiate(fromStoryboard: "Clothes")
//        addClotheViewController.setupView(viewModel: AddClotheViewMothel())
//        navigationController.pushViewController(addClotheViewController, animated: true)
//    }
    
    //MARK:- MVP Methods
    func start() {
        let clotheViewControllerMVP = ClotheViewControllerMVP.instantiate(fromStoryboard: "ClothesMVP")
        let presenter = ClothePresenter(withDressMaker: DressMaker(container: UIApplication.container), coordinator: self)
        presenter.attach(view: clotheViewControllerMVP as ClotheViewable)
        navigationController.pushViewController(clotheViewControllerMVP, animated: true)
    }

    func addClothe() {
        let addClotheViewControllerMVP = AddClotheViewControllerMVP.instantiate(fromStoryboard: "ClothesMVP")
        let presenter = AddClothePresenter(withDressMaker: DressMaker(container: UIApplication.container))
        presenter.attach(view: addClotheViewControllerMVP as AddClotheViewable)
        navigationController.pushViewController(addClotheViewControllerMVP, animated: true)
    }
}
