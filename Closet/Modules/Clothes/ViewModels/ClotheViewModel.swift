//
//  ClotheViewModel.swift
//  Closet
//
//  Created by chila on 6/15/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class ClotheViewModel {
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
    private var dressMaker: DressMaker
    private var _clothes: [Clothe]?
    
    init() {
        dressMaker = DressMaker(container: UIApplication.container)
    }
    
    func refreshFromDatabase() {
        _clothes = dressMaker.fetchAllClothes() ?? [Clothe]()
    }
}
