//
//  OutfitPresenter.swift
//  Closet
//
//  Created by Chila on 7/2/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class OutfitPresenter: OutfitPresentable {
    private weak var view: OutfitViewable?
    private var coordinator: OutfitsRouter!
    private var screenTitle: String = "Outfits"
    private var fashionMaker: FashionmakerReadable
    
    init(withFashionMaker fashionMaker: FashionmakerReadable, coordinator: OutfitsRouter) {
        self.coordinator = coordinator
        self.fashionMaker = fashionMaker
        NotificationCenter.default.addObserver(forName: .coreDataDidSavedOutfit, object: nil, queue: nil) { [weak self] (info) in
            guard let isSaved = info.userInfo?["saved"] as? Bool else { return }
            if isSaved {
                self?.fetchOutfits()
            }
        }
    }
    
    func attach(view: OutfitViewable) {
        self.view = view
        self.view?.setup(title: screenTitle, presenter: self as OutfitPresentable)
        self.view?.setSection(icon: "man", title: screenTitle)
        self.view?.showAddButton(action: {
            self.coordinator.addOutfit()
        })
    }
    
    func fetchOutfits() {
        let outfits = fashionMaker.fetchAllOutfits() ?? [Outfit] ()
        view?.show(outfits: outfits)
    }
}
