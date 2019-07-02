//
//  ClothePresentable.swift
//  Closet
//
//  Created by chila on 6/29/19.
//  Copyright © 2019 chila. All rights reserved.
//

import Foundation

class ClothePresenter: ClothePresentable {
    private weak var view: ClotheViewable?
    private var coordinator: ClothesCoordinator!
    private var screenTitle: String = "Clothes"
    private var dressMaker: DressMaker
    
    init(withDressMaker dressMaker: DressMaker, coordinator: ClothesCoordinator) {
        self.coordinator = coordinator
        self.dressMaker = dressMaker
    }
    
    func attach(view: ClotheViewable) {
        self.view = view
        self.view?.setup(title: screenTitle, presenter: self as ClothePresentable)
        self.view?.setSection(icon: "shirt", title: screenTitle)
        self.view?.showAddButton(action: {
            self.coordinator.addClothe()
        })
    }
}
