//
//  AddOutfitViewController.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class AddOutfitViewController: UIViewController, Storyboarded {

    private var viewModel: AddOutfitViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func setupView(viewModel: AddOutfitViewModel) {
        self.viewModel = viewModel
    }
    
    private func initialize() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addOutfit))
        navigationItem.rightBarButtonItems = [addButtonItem]
    }
    
    @objc private func addOutfit() {
        print("lol")
    }
}
