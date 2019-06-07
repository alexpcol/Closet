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
    
    func fetchAllClothes() -> [Clothe]? {
        guard let result = fetchAllClothesDatabase() else { return nil }
        let clothes = result.map { (item) -> Clothe in
            
            let color = item.color as! UIColor
            let piece = PieceType.with(text: item.piece)
            let style = ClotheStyle.with(text: item.style)
            
            return Clothe(id: item.objectID.uriRepresentation(),
                          color: color,
                          piece: piece,
                          style: style)
        }
        return clothes
        
    }
    
    func fetchClothe(withId id: URL) -> Clothe? {
        guard let clotheDatabase = fetchDatabaseClothe(withId: id) else { return nil }
        let color = clotheDatabase.color as! UIColor
        let piece = PieceType.with(text: clotheDatabase.piece)
        let style = ClotheStyle.with(text: clotheDatabase.style)
        
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
        clothe.outfit = nil // is this ok?
        save()
    }
    
    func update(clothe: Clothe) {
        guard let clotheDatabase = fetchDatabaseClothe(withId: clothe.id) else { return }
        clotheDatabase.color = clothe.color
        clotheDatabase.piece = clothe.piece.rawValue
        clotheDatabase.style = clothe.style.rawValue
        save()
    }
    //MARK:- I think it's not necessary 
//    func updateClothe(withId id: URL, changingColor color: UIColor) {
//        guard let clotheDatabase = fetchDatabaseClothe(withId: id) else { return }
//        clotheDatabase.color = color
//        save()
//    }
//
//    func updateClothe(withId id: URL, changingPiece piece: PieceType) {
//        guard let clotheDatabase = fetchDatabaseClothe(withId: id) else { return }
//        clotheDatabase.piece = piece.rawValue
//        save()
//    }
//
//    func updateClothe(withId id: URL, changingStyle style: ClotheStyle) {
//        guard let clotheDatabase = fetchDatabaseClothe(withId: id) else { return }
//        clotheDatabase.style = style.rawValue
//        save()
//    }
    
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
    
    private func fetchAllClothesDatabase() -> [ClotheDatabase]? {
        let request: NSFetchRequest<ClotheDatabase> = ClotheDatabase.fetchRequest()
        do{
            return try self.container.viewContext.fetch(request)
        } catch {
            return nil
        }
    }
    
    private func fetchDatabaseClothe(withId id: URL) -> ClotheDatabase? {
        guard let managedID = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: id) else {
            return nil
        }
        return try? backgroundContext.existingObject(with: managedID) as? ClotheDatabase
    }
}
