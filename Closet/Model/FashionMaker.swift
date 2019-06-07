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
    lazy var backgroundContext: NSManagedObjectContext = {
        return container.newBackgroundContext()
    }()
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func fetchOutfit(withId id: URL) -> Outfit? {
        guard let outfitDatabase = fetchDatabaseOutfit(withId: id) else { return nil }
        guard let clothesDatabase = outfitDatabase.clothes else { return nil }
        var clothes:[Clothe] = []
        for case let item as ClotheDatabase in clothesDatabase {
            
            guard let color = item.color as? UIColor,
                let pieceDatabase = item.piece,
                let piece = PieceType(rawValue: pieceDatabase),
                let styleDatabase = item.style,
                let style = ClotheStyle(rawValue: styleDatabase)
                else { continue }
            
            let clothe = Clothe(id: item.objectID.uriRepresentation(),
                                color: color,
                                piece: piece,
                                style: style)
            clothes.append(clothe)
        }
        return Outfit(id: outfitDatabase.objectID.uriRepresentation(), clothes: clothes)
    }
    
    func addOutfit(name: String, clothes: [Clothe]) { //should it be called 'add' also? or like the commmon action like createOutfit
        let outfit = OutfitDatabase(entity: OutfitDatabase.entity(), insertInto: backgroundContext)
        outfit.name = name
        outfit.clothes = NSSet(object: clothes)
        save()
    }
    
    private func save() {
        if backgroundContext.hasChanges {
            do{
                try backgroundContext.save()
            } catch  {
                print("Save Error:\(error)")
            }
        }
    }
    
    private func fetchDatabaseOutfit(withId id: URL) -> OutfitDatabase? {
        guard let managedID = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: id) else {
            return nil
        }
        return try? backgroundContext.existingObject(with: managedID) as? OutfitDatabase
    }
    
    
}
