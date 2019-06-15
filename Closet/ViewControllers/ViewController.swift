//
//  ViewController.swift
//  Closet
//
//  Created by chila on 5/25/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dressMaker: DressMaker?
    var fashionMaker: FashionMaker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //createClotheRecords()
        //fetchClothes()
        //createOutfitRecord()
        fetchOutfits()
    }
    
    private func fetchClothes() {
        guard  let clothes = dressMaker?.fetchAllClothes() else { return }
        for clothe in clothes {
            print(clothe)
        }
    }
    
    
    private func fetchOutfits() {
        guard let outfits = fashionMaker?.fetchAllOutfits() else { return }
        for outfit in outfits {
            for clothe in outfit.clothes {
                print(clothe.piece)
            }
        }
    }
    
    private func createClotheRecords() {
        dressMaker?.add(Clothe.clotheForDressMakerAdd(color: .red, piece: .top, style: .casual))
        dressMaker?.add(Clothe.clotheForDressMakerAdd(color: .green, piece: .trouser, style: .casual))
        dressMaker?.add(Clothe.clotheForDressMakerAdd(color: .blue, piece: .footwear, style: .casual))
    }
    
    private func createOutfitRecord() {
        guard let clothes = dressMaker?.fetchAllClothes() else { return }
        let outfit = Outfit.outfitForFashionMakerAdd(name: "Summer", clothes: clothes)
        fashionMaker?.add(outfit)
    }
    
    private func setUp() {
        dressMaker = DressMaker(container: self.container)
        fashionMaker = FashionMaker(container: self.container)
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
    }


}

