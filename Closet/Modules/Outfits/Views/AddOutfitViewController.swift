//
//  AddOutfitViewController.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class AddOutfitViewController: UIViewController, Storyboarded {

    weak var coordinator: OutfitsCoordinator?
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
    
    @IBAction func clothePieceTapped(_ sender: UIButton) {
        switch sender.tag {
        case FormTags.buttonAddTopPiece.rawValue:
            coordinator?.pickClothe(withPiece: .top)
        case FormTags.buttonAddTrouserPiece.rawValue:
            coordinator?.pickClothe(withPiece: .trouser)
        case FormTags.buttonAddFootwearPiece.rawValue:
            coordinator?.pickClothe(withPiece: .footwear)
        default:
            print("default")
        }
    }
    
    
    @objc private func addOutfit() {
        print("lol")
    }
}
