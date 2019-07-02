//
//  AddOutfitPresenter.swift
//  Closet
//
//  Created by Mauricio Conde on 7/2/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class AddOutfitPresenter: AddOutfitPresentable {
    private var name: String?
    private var topClothe: Clothe?
    private var trouserClothe: Clothe?
    private var footwearClothe: Clothe?
    private var coordinator: OutfitsCoordinator!
    private var fashionMaker: FashionMaker
    private weak var view: AddOutfitViewable?
    
    init(withFashionMaker fashionMaker: FashionMaker, coordinator: OutfitsCoordinator) {
        self.coordinator = coordinator
        self.fashionMaker = fashionMaker
    }
    
    func attach(view: AddOutfitViewable) {
        self.view = view
        self.view?.setup(title: "New", presenter: self as AddOutfitPresentable)
        self.view?.showSaveButton(action: {
            self.saveOutfit()
        })
    }
    
    func startEditing(name: String) {
        self.name = name
    }
    
    func startEditing(pieceType type: PieceType) {
        coordinator.pickClothe(in: self, withPiece: type)
    }
    
    private func saveOutfit() -> AlertHeaderModel {
        return AlertHeaderModel(title: "Closet", message: "Verifica tu información")
    }
    
    private func validateForm() -> Bool {
        if name == nil {
            return false
        }
        if topClothe == nil {
            return false
        }
        if trouserClothe == nil {
            return false
        }
        return true
    }
}

extension AddOutfitPresenter: ClothePicked {
    func didSelectClothe(_ clothe: Clothe) {
        print(clothe.piece)
    }
}
