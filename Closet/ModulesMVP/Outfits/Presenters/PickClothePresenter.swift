//
//  PickClothePresenter.swift
//  Closet
//
//  Created by Mauricio Conde on 7/2/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class PickClothePresenter: PickClothePresentable {
    private var clothes = [Clothe]()
    private var dressMaker: DressMaker
    private var pieceSelected: PieceType
    private var delegate: ClothePicked
    private weak var view: PickClotheViewable?
    
    init(withDressMaker dressMaker: DressMaker, PieceType type: PieceType, andDelegate delegate: ClothePicked) {
        self.dressMaker = dressMaker
        self.delegate = delegate
        pieceSelected = type
    }
    
    func attach(view: PickClotheViewable) {
        self.view = view
        self.view?.setup(title: "Clothes", presenter: self)
        self.view?.showCloseButton()
    }
    
    func fetchClothes() {
        clothes = dressMaker.fetchBy(piece: pieceSelected)
        view?.show(clothes: clothes)
    }
    
    func didSelectOption(index: Int) {
        delegate.didSelectClothe(clothes[index], forPieceType: pieceSelected)
    }
}
