//
//  ClotheViewModel.swift
//  Closet
//
//  Created by chila on 6/15/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class ClotheViewModel {
    var clothes:Dynamic<[Clothe]>  {
        get {
            if _clothes.value.isEmpty {
                refreshFromDatabase()
            }
            return _clothes
        }
        set {
            
        }
    }
    var clotheCellModel: [ClotheCellModel]  {
        get {
            return clothes.value.map({ (clothe: Clothe) -> ClotheCellModel in
                ClotheCellModel(typeIcon: clothe.piece.icon(), preview: clothe.image, name: clothe.style.rawValue)
            })
        }
    }
    private var dressMaker: DressMaker
    private var _clothes: Dynamic<[Clothe]>
    
    init() {
        dressMaker = DressMaker(container: UIApplication.container)
        _clothes = Dynamic([Clothe]())
        NotificationCenter.default.addObserver(forName: .coreDataDidSavedClothe, object: nil, queue: nil) { [weak self] (info) in
            guard let isSaved = info.userInfo?["saved"] as? Bool else { return }
            if isSaved {
                self?.refreshFromDatabase()
                self?.clothes = self!._clothes
            }
        }
    }
    
    func refreshFromDatabase() {
        _clothes.value = dressMaker.fetchAllClothes() ?? _clothes.value
        
    }
}
