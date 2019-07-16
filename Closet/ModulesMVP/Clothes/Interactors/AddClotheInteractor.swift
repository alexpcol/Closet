//
//  AddClotheInteractor.swift
//  Closet
//
//  Created by chila on 7/13/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit
import CoreData

class AddClotheInteractor: DressmakerEditable {
    let dressMaker: DressMaker
    
    init(withContainer container: NSPersistentContainer) {
        dressMaker = DressMaker(container: container)
    }
    
    func add(_ clothes: [Clothe]) {
        clothes.forEach {
            createClotheDatabaseEntity(clothe: $0, inContext: dressMaker.backgroundContext)
        }
        dressMaker.save()
    }
    
    func update(_ clothes: [Clothe]) {
        for clothe in clothes {
            dressMaker.fetchDatabaseClothe(withId: clothe.id) {
                $0?.color = clothe.color
                $0?.piece = clothe.piece.rawValue
                $0?.style = clothe.style.rawValue
            }
        }
        dressMaker.save()
    }
    
    func remove(_ clothes: [Clothe]) {
        for clothe in clothes {
            dressMaker.fetchDatabaseClothe(withId: clothe.id) {
                if let clothe = $0 {
                    self.dressMaker.backgroundContext.delete(clothe)
                }
            }
        }
        dressMaker.save()
    }
    
    private func createClotheDatabaseEntity(clothe: Clothe, inContext context: NSManagedObjectContext) {
        let clotheDatabase = ClotheDatabase(entity: ClotheDatabase.entity(), insertInto: context)
        clotheDatabase.style = clothe.style.rawValue
        clotheDatabase.color = clothe.color
        clotheDatabase.piece = clothe.piece.rawValue
        clotheDatabase.image = clothe.image.jpegData(compressionQuality: 0.75)! as NSData
        clotheDatabase.outfit = nil
    }
}
