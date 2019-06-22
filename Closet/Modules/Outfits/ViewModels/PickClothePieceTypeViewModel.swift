//
//  PickClothePieceTypeViewModel.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class PickClothePieceTypeViewModel {
    var clothes: [Clothe]  {
        get {
            if _clothes == nil {
                refreshFromDatabase()
            }
            return _clothes!
        }
    }
    var clotheCellModel: [ClotheCellModel]  {
        get {
            return clothes.map({ (clothe: Clothe) -> ClotheCellModel in
                ClotheCellModel(typeIcon: clothe.piece.icon(), preview: clothe.image, name: clothe.style.rawValue)
            })
        }
    }
    private var piece: PieceType
    private var dressMaker: DressMaker
    private var _clothes: [Clothe]?
    
    init(piece: PieceType) {
        dressMaker = DressMaker(container: UIApplication.container)
        self.piece = piece
    }
    
    private func refreshFromDatabase() {
        _clothes = dressMaker.fetchBy(piece: piece)
        
    }
}
