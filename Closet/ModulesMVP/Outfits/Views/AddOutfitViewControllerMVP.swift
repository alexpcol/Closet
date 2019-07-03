//
//  AddOutfitViewControllerMVP.swift
//  Closet
//
//  Created by Mauricio Conde on 7/2/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class AddOutfitViewControllerMVP: GenericFormVC, Storyboarded, AddOutfitViewable {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var clotheTop: UIImageView!
    @IBOutlet weak var clotheTrouser: UIImageView!
    @IBOutlet weak var clotheFootwear: UIImageView!
    
    private var presenter: AddOutfitPresentable!
    private var saveButtonAction:(() -> AlertHeaderModel)!
    
    func showSaveButton(action: @escaping () -> AlertHeaderModel) {
        saveButtonAction = action
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapSaveButton))
        navigationItem.rightBarButtonItems = [addButtonItem]
    }
    
    func setup(title: String, presenter: AddOutfitPresentable) {
        self.title = title
        self.presenter = presenter
    }
    
    func show(clothe: Clothe, forPieceType type: PieceType) {
        switch type {
        case .top:
            clotheTop.image = clothe.image
        case .trouser:
            clotheTrouser.image = clothe.image
        case .footwear:
            clotheFootwear.image = clothe.image
        }
    }
    
    //MARK:- Actions
    @IBAction func didSelectTop(_ sender: UIButton) {
        presenter.startEditing(pieceType: .top)
    }
    @IBAction func didSelectTrouser(_ sender: UIButton) {
        presenter.startEditing(pieceType: .trouser)
    }
    @IBAction func disSelectFootwear(_ sender: UIButton) {
        presenter.startEditing(pieceType: .footwear)
    }
    
    @objc private func didTapSaveButton() {
        let resultModel = saveButtonAction()
        AlertsPresenter.shared.showOKAlert(title: resultModel.title, message: resultModel.message, inView: self)
    }
}

extension AddOutfitViewControllerMVP {
    override func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text,textField == nameText {
            presenter.startEditing(name: text)
        }
    }
}
