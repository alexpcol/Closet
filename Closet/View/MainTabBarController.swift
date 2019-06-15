//
//  MainTabBarController.swift
//  Closet
//
//  Created by chila on 6/15/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    let clothesFlow = ClothesCoordinator(navigationController: UINavigationController())
    let outfitsFlow = OutfitsCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clothesFlow.start()
        outfitsFlow.start()
        viewControllers = [clothesFlow.navigationController, outfitsFlow.navigationController]
    }
    

}
