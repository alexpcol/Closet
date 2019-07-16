//
//  MainTabBarController.swift
//  Closet
//
//  Created by chila on 6/15/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    let clothesFlow = ClothesRouter(navigationController: UINavigationController())
    let outfitsFlow = OutfitsRouter(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clothesFlow.start()
        outfitsFlow.start()
        viewControllers = [clothesFlow.navigationController, outfitsFlow.navigationController]
    }
    

}
