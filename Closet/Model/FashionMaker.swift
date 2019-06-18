//
//  OutfitMaker.swift
//  Closet
//
//  Created by chila on 6/2/19.
//  Copyright © 2019 chila. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FashionMaker {
    private let container: NSPersistentContainer
    private let dressMaker: DressMaker
    lazy var backgroundContext: NSManagedObjectContext = {
        return container.viewContext
    }()
    
    init(container: NSPersistentContainer) {
        self.container = container
        dressMaker = DressMaker(container: container)
    }
    
    func fetchAllOutfits() -> [Outfit]? {
        guard let result = fetchAllDatabaseOutfit() else { return nil }
        let outfits = result.map { (item) -> Outfit in
           return Outfit(id: item.objectID.uriRepresentation(), name: item.name, clothes: item.clothes)
        }
        return outfits
    }
    
    func fetchOutfit(withId id: URL) -> Outfit? {
        guard let outfitDatabase = fetchDatabaseOutfit(withId: id),
        let name = outfitDatabase.name else { return nil }
        let clothesDatabase = outfitDatabase.clothes
        var clothes = [Clothe]()
        for case let item as ClotheDatabase in clothesDatabase {
            clothes.append(Clothe(id: item.objectID.uriRepresentation(),
                                  color: item.color,
                                  piece: item.piece,
                                  style: item.style,
                                  image: item.image))
        }
        
        return Outfit(id: outfitDatabase.objectID.uriRepresentation(), name: name, clothes: clothes)
    }
    
    func add(_ outfit: Outfit) {
        let outfitDatabase = OutfitDatabase(entity: OutfitDatabase.entity(), insertInto: backgroundContext)
        outfitDatabase.name = outfit.name
        for clothe in outfit.clothes {
            guard let clotheDatabase = dressMaker.fetchDatabaseClothe(withId: clothe.id) else { continue }
            outfitDatabase.addToClothes(clotheDatabase)
        }
        save()
    }
    
    func update(_ outfit: Outfit) {
        guard let outfitDatabase = fetchDatabaseOutfit(withId: outfit.id) else { return }
        outfitDatabase.name = outfit.name
        outfitDatabase.clothes = NSSet(array: outfit.clothes)
        save()
    }
    
    func remove(_ outfit: Outfit) {
        guard let outfitDatabase = fetchDatabaseOutfit(withId: outfit.id) else { return }
        backgroundContext.delete(outfitDatabase)
        save()
    }
    
    private func save() {
        if backgroundContext.hasChanges {
            do{
                try backgroundContext.save()
                print("Saved!!!")
            } catch  {
                print("Save Error:\(error)")
            }
        }
    }
    
    private func fetchAllDatabaseOutfit() -> [OutfitDatabase]? {
        let request: NSFetchRequest<OutfitDatabase> = OutfitDatabase.fetchRequest()
        do{
            return try self.container.viewContext.fetch(request)
        } catch {
            return nil
        }
    }
    
    private func fetchDatabaseOutfit(withId id: URL) -> OutfitDatabase? {
        guard let managedID = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: id) else {
            return nil
        }
        return try? backgroundContext.existingObject(with: managedID) as? OutfitDatabase
    }
    
    
}
