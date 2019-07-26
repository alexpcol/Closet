//
//  AddOutfitInteractor.swift
//  Closet
//
//  Created by chila on 7/16/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit
import CoreData

class AddOutfitInteractor: FashionmakerEditable {
    let fashionMaker: FashionMaker
    private let dressMaker: DressMaker
    init(withContainer container: NSPersistentContainer) {
        fashionMaker = FashionMaker(container: container)
        dressMaker = DressMaker(container: container)
    }

    func add(_ outfits: [Outfit]) {
        outfits.forEach {
            createOutfitDatabaseEntity(outfit: $0, inContext: fashionMaker.backgroundContext)
        }
        fashionMaker.save()
    }
    
    func update(_ outfits: [Outfit]) {
        for outfit in outfits {
            fashionMaker.fetchDatabaseOutfit(withId: outfit.id) {
                $0?.name = outfit.name
                self.updateClothesInOutfit(outfitDatabase: $0!, clothes: outfit.clothes)
            }
        }
        fashionMaker.save()
    }
    
    func remove(_ outfits: [Outfit]) {
        for outfit in outfits {
            fashionMaker.fetchDatabaseOutfit(withId: outfit.id) {
                if let outfit = $0 {
                    self.fashionMaker.backgroundContext.delete(outfit)
                }
            }
        }
        fashionMaker.save()
    }
    
    
    private func updateClothesInOutfit(outfitDatabase: OutfitDatabase, clothes: [Clothe]) {
        for (index, outfitClothe) in outfitDatabase.clothes.enumerated() {
            if let clotheDatabase = outfitClothe as? ClotheDatabase {
                clotheDatabase.color = clothes[index].color
                clotheDatabase.image = clothes[index].image.jpegData(compressionQuality: 0.75)! as NSData
                clotheDatabase.piece = clothes[index].piece.rawValue
                clotheDatabase.style = clothes[index].style.rawValue
            }
        }
    }
    
    private func createOutfitDatabaseEntity(outfit: Outfit, inContext context: NSManagedObjectContext) {
        let outfitDatabase = OutfitDatabase(context: context)
        outfitDatabase.name = outfit.name
        for clothe in outfit.clothes {
            dressMaker.fetchDatabaseClothe(withId: clothe.id) { (clotheDatabse) in
                if let clothe = clotheDatabse {
                    outfitDatabase.addToClothes(clothe)
                }
            }
        }
        fashionMaker.save()
    }
    
}
