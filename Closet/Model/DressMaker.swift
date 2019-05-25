//
//  DressMaker.swift
//  Closet
//
//  Created by chila on 5/25/19.
//  Copyright © 2019 chila. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DressMaker {
    private let container: NSPersistentContainer
    lazy var backgroundContext: NSManagedObjectContext = {
        return container.newBackgroundContext()
    }()
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    // TODO: fetch for clothe or atribute: predicate, method for each type, clothe with specified atributes
    func fetchClothe(withId id: URL) -> Clothe? {
        guard let clotheDatabase = fetchDatabaseClothe(withId: id),
            let color = clotheDatabase.color as? UIColor,
            let pieceDatabase = clotheDatabase.piece,
            let piece = PieceType(rawValue: pieceDatabase),
            let styleDatabase = clotheDatabase.style,
            let style = ClotheStyle(rawValue: styleDatabase)
            else { return nil }
        
        return Clothe(id: clotheDatabase.objectID.uriRepresentation(),
                      color: color,
                      piece: piece,
                      style: style)
    }
    
    func addClothe(style: ClotheStyle, color: UIColor, piece: PieceType) {
        let clothe = ClotheDatabase(entity: ClotheDatabase.entity(), insertInto: backgroundContext)
        clothe.style = style.rawValue
        clothe.color = color
        clothe.piece = piece.rawValue
        save()
    }
    
    //TODO: Next class should this would be in a clothe extension?
    func updateClothe(withId id: URL, changingColor color: UIColor) {
        guard let clotheDatabase = fetchDatabaseClothe(withId: id) else { return }
        clotheDatabase.color = color
        save()
    }
    
    func updateClothe(withId id: URL, changingPiece piece: PieceType) {
        guard let clotheDatabase = fetchDatabaseClothe(withId: id) else { return }
        clotheDatabase.piece = piece.rawValue
        save()
    }
    
    func updateClothe(withId id: URL, changingStyle style: ClotheStyle) {
        guard let clotheDatabase = fetchDatabaseClothe(withId: id) else { return }
        clotheDatabase.style = style.rawValue
        save()
    }
    
    func removeClothe(withId id: URL) {
        guard let clotheDatabase = fetchDatabaseClothe(withId: id) else { return }
        backgroundContext.delete(clotheDatabase)
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
    
    private func fetchDatabaseClothe(withId id: URL) -> ClotheDatabase? {
        guard let managedID = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: id) else {
            return nil
        }
        return try? backgroundContext.existingObject(with: managedID) as? ClotheDatabase
    }
}
