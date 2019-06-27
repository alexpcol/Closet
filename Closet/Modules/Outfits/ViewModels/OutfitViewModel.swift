//
//  OutfitViewModel.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class OutfitViewModel {
    var outfits:Dynamic<[Outfit]>   {
        get {
            if _outfits.value.isEmpty {
                refreshFromDatabase()
            }
            return _outfits
        }
        set {
            
        }
    }
    var outfitCellModel: [OutfitCellModel]  {
        get {
            return outfits.value.map({ (outfit: Outfit) -> OutfitCellModel in
                OutfitCellModel(name: outfit.name)
            })
        }
    }
    private var fashionMaker: FashionMaker
    private var _outfits: Dynamic<[Outfit]>
    
    init() {
        fashionMaker = FashionMaker(container: UIApplication.container)
        _outfits = Dynamic([Outfit]())
        NotificationCenter.default.addObserver(forName: .coreDataDidSavedOutfit, object: nil, queue: nil) { [weak self] (info) in
            guard let isSaved = info.userInfo?["saved"] as? Bool else { return }
            if isSaved {
                self?.refreshFromDatabase()
                self?.outfits = self!._outfits
            }
        }
    }
    
    func refreshFromDatabase() {
        _outfits.value = fashionMaker.fetchAllOutfits() ?? _outfits.value
    }
}

