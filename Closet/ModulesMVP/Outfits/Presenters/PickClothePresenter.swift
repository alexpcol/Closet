//
//  PickClothePresenter.swift
//  Closet
//
//  Created by Mauricio Conde on 7/2/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class PickClothePresenter: PickClothePresentable {
    private var dressMaker: DressMaker
    private var pieceSelected: PieceType
    private weak var view: PickClotheViewable?
    init(withDressMaker dressMaker: DressMaker, andPieceType type: PieceType) {
        self.dressMaker = dressMaker
        pieceSelected = type
    }
    
    func attach(view: PickClotheViewable) {
        self.view = view
    }
}
