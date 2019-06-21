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
    var piece: String
    private var dressMaker: DressMaker
    private var _clothes: [Clothe]?
    
    init() {
        dressMaker = DressMaker(container: UIApplication.container)
        piece = ""
    }
    
    func refreshFromDatabase() {
        let pieceType = PieceType.with(text: piece)
        switch pieceType {
        case .top:
           _clothes = dressMaker.fetchAllTops() ?? [Clothe]()
        case .trouser:
           _clothes = dressMaker.fetchAllTrousers() ?? [Clothe]()
        case .footwear:
           _clothes = dressMaker.fetchAllFootwears() ?? [Clothe]()
        }
        
    }
}
