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
    private var coordinator: ClothesRouter!
    private var screenTitle: String = "Ropa"
    private var dressMaker: DressmakerReadable
    
    init(withDressMaker dressMaker: DressmakerReadable, coordinator: ClothesRouter) {
        self.coordinator = coordinator
        self.dressMaker = dressMaker
        NotificationCenter.default.addObserver(forName: .coreDataDidSavedClothe, object: nil, queue: nil) { [weak self] (info) in
            guard let isSaved = info.userInfo?["saved"] as? Bool else { return }
            if isSaved {
                self?.fetchClothes()
            }
        }
    }
    
    func attach(view: ClotheViewable) {
        self.view = view
        self.view?.setup(title: screenTitle, presenter: self as ClothePresentable)
        self.view?.setSection(icon: "shirt", title: screenTitle)
        self.view?.showAddButton(action: {
            self.coordinator.addClothe()
        })
    }
    
    func fetchClothes() {
        let clothes = dressMaker.fetchAllClothes() ?? [Clothe]()
        view?.show(clothes: clothes)
    }
}
