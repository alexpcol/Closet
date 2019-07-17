//
//  PickClothePresenter.swift
//  Closet
//
//  Created by Chila on 7/2/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class PickClothePresenter: PickClothePresentable {
    private var clothes = [Clothe]()
    private var dressMaker: DressmakerReadable
    private var pieceSelected: PieceType
    private var delegate: ClothePicked
    private weak var view: PickClotheViewable?
    
    init(withDressMaker dressMaker: DressmakerReadable, PieceType type: PieceType, andDelegate delegate: ClothePicked) {
        self.dressMaker = dressMaker
        self.delegate = delegate
        pieceSelected = type
    }
    
    func attach(view: PickClotheViewable) {
        self.view = view
        self.view?.setup(title: "Ropa", presenter: self)
        self.view?.showCloseButton()
    }
    
    func fetchClothes() {
        dressMaker.fetchBy(piece: pieceSelected) {
            if let clothes = $0 {
                self.view?.show(clothes: clothes)
            }
        }
    }
    
    func didSelectOption(index: Int) {
        delegate.didSelectClothe(clothes[index], forPieceType: pieceSelected)
    }
}
