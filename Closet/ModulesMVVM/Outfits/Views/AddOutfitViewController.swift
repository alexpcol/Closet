//
//  AddOutfitViewController.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class AddOutfitViewController: GenericFormVC, Storyboarded {
    weak var coordinator: OutfitsCoordinator?
    @IBOutlet private weak var outfitName: UITextField!
    @IBOutlet private weak var clotheTop: UIImageView!
    @IBOutlet private weak var clotheTrouser: UIImageView!
    @IBOutlet private weak var clotheFootwear: UIImageView!
    private var viewModel: AddOutfitViewModel!
    
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
        outfitName.tag = FormTags.textFieldAddOutfitName.rawValue
        outfitName.delegate = self
        setViewModelProperties()
    }
    
    @IBAction func clothePieceTapped(_ sender: UIButton) {
//        switch sender.tag {
//        case FormTags.buttonAddTopPiece.rawValue:
//            coordinator?.pickClothe(in: self, withPiece: .top)
//        case FormTags.buttonAddTrouserPiece.rawValue:
//            coordinator?.pickClothe(in: self, withPiece: .trouser)
//        case FormTags.buttonAddFootwearPiece.rawValue:
//            coordinator?.pickClothe(in: self, withPiece: .footwear)
//        default:
//            print("default")
//        }
    }
    
    
    @objc private func addOutfit() {
        let resultModel = viewModel.addOutfit()
        AlertsPresenter.shared.showOKAlert(title: resultModel.title, message: resultModel.message, inView: self)
    }
    
    private func setViewModelProperties() {
        viewModel.name.bindAndFire({ [unowned self] in
            self.outfitName.text = $0
        })
        viewModel.clotheTop.bindAndFire({ [unowned self] (clothe) in
            self.clotheTop.image = clothe.image
        })
        viewModel.clotheTrouser.bindAndFire({ [unowned self] (clothe) in
            self.clotheTrouser.image = clothe.image
        })
        viewModel.clotheFootwear.bindAndFire({ [unowned self] (clothe) in
            self.clotheFootwear.image = clothe.image
        })
    }
}

extension AddOutfitViewController {
    override func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text ?? ""
        if textField.tag == FormTags.textFieldAddOutfitName.rawValue {
            viewModel.name.value = text
        }
    }
}

extension AddOutfitViewController: ClothePicked {
    func didSelectClothe(_ clothe: Clothe, forPieceType piece: PieceType) {
        print(clothe)
    }
    
//    func didSelectClothe(_ clothe: Clothe) {
//        switch clothe.piece {
//        case .top:
//            viewModel.clotheTop.value = clothe
//        case .trouser:
//            viewModel.clotheTrouser.value = clothe
//        case .footwear:
//            viewModel.clotheFootwear.value = clothe
//        }
//    }
}
