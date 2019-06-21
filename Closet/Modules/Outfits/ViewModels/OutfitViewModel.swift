//
//  OutfitViewModel.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class OutfitViewModel {
    var outfits: [Outfit]  {
        get {
            if _outfits == nil {
                refreshFromDatabase()
            }
            return _outfits!
        }
    }
    var outfitCellModel: [OutfitCellModel]  {
        get {
            return outfits.map({ (outfit: Outfit) -> OutfitCellModel in
                OutfitCellModel(name: outfit.name)
            })
        }
    }
    private var fashionMaker: FashionMaker
    private var _outfits: [Outfit]?
    
    init() {
        fashionMaker = FashionMaker(container: UIApplication.container)
    }
    
    func refreshFromDatabase() {
        _outfits = fashionMaker.fetchAllOutfits() ?? [Outfit]()
    }
}

