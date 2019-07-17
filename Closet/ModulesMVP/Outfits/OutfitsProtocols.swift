//
//  OutfitsProtocols.swift
//  Closet
//
//  Created by Chila on 7/2/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

//MARK:- Outfits
protocol OutfitPresentable {
    func fetchOutfits()
}

protocol OutfitViewable: class {
    func showAddButton(action: @escaping () -> Void)
    func setup(title: String, presenter: OutfitPresentable)
    func setSection(icon: String, title: String)
    func show(outfits:[Outfit])
}

//MARK:- AddCOutfits
protocol AddOutfitPresentable {
    func startEditing(name: String)
    func startEditing(pieceType type: PieceType)
}

protocol AddOutfitViewable: class {
    func showSaveButton(action: @escaping () -> AlertHeaderModel)
    func setup(title: String, presenter: AddOutfitPresentable)
    func show(clothe: Clothe, forPieceType type: PieceType)
}

//MARK:- PickClothes
protocol PickClothePresentable {
    func fetchClothes()
    func didSelectOption(index: Int)
}

protocol PickClotheViewable: class {
    func show(clothes:[Clothe])
    func setup(title: String, presenter: PickClothePresentable)
    func showCloseButton()
}
