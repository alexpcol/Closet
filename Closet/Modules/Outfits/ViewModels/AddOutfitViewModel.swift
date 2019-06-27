//
//  AddOutfitViewModel.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class AddOutfitViewModel {
    var name: Dynamic<String>
    var clotheTop: Dynamic<Clothe>
    var clotheTrouser: Dynamic<Clothe>
    var clotheFootwear: Dynamic<Clothe>
    
    private var fashionMaker: FashionMaker
    
    init() {
        fashionMaker = FashionMaker(container: UIApplication.container)
        name = Dynamic("")
        clotheTop = Dynamic(Clothe.clotheForDressMakerAdd(color: .clear, piece: .footwear, style: .sport, image: UIImage(named: "clothePlaceholder")!))
        clotheTrouser = Dynamic(Clothe.clotheForDressMakerAdd(color: .clear, piece: .footwear, style: .sport, image: UIImage(named: "clothePlaceholder")!))
        clotheFootwear = Dynamic(Clothe.clotheForDressMakerAdd(color: .clear, piece: .footwear, style: .sport, image: UIImage(named: "clothePlaceholder")!))
    }
    func addOutfit() -> AlertHeaderModel {
        if validateForm() {
            let outfit = Outfit(name: name.value, clothes: [clotheTop.value, clotheTrouser.value, clotheFootwear.value])
            fashionMaker.add(outfit)
            return AlertHeaderModel(title: "Closet", message: "¡Outfit añadido!")
        }
        return AlertHeaderModel(title: "Closet", message: "Verifica tu información")
    }
    
    private func validateForm() -> Bool {
        if name.value.isEmpty {
            return false
        }
        if clotheTop.value.color == .clear{
            return false
        }
        if clotheTrouser.value.color == .clear{
            return false
        }
        if clotheFootwear.value.color == .clear{
            return false
        }
        return true
    }
    
}
