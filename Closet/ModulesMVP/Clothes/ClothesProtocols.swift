//
//  ClothesProtocols.swift
//  Closet
//
//  Created by chila on 6/29/19.
//  Copyright © 2019 chila. All rights reserved.
//

import Foundation
import UIKit


//MARK:- Clothes
protocol ClothePresentable {
}

protocol ClotheViewable: class {
    func showAddButton(action: @escaping () -> Void)
    func setup(title: String, presenter: ClothePresentable)
    func setSection(icon: String, title: String)
}

//MARK:- AddClothes
protocol AddClothePresentable {
    func startEditing(property: ClotheProperties)
    func didSelectAddImge()
}

protocol AddClotheViewable: class {
    func showSaveButton(action: @escaping () -> Void)
    func setup(title: String, presenter: AddClothePresentable)
    func show(clotheImage: UIImage)
    func showClothe(property: ClotheProperties, text: String)
    func showPicker(with options: [String], didSelect:@escaping (Int) -> Void)
}

