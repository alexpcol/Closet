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
        return container.viewContext
    }()
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func fetchAllClothes() -> [Clothe]? {
        guard let result = fetchAllClothesDatabase() else { return nil }
        let clothes = result.map { (item) -> Clothe in
            return Clothe(id: item.objectID.uriRepresentation(),
                          color: item.color,
                          piece: item.piece,
                          style: item.style,
                          image: item.image)
        }
        return clothes
    }
    
    func fetchAllTops() ->[Clothe]? {
        let predicate = NSPredicate(format: "piece == %@", PieceType.top.rawValue)
        guard let result = fetchClothes(withPredicate: predicate) else { return nil }
        let clothes = result.map { (item) -> Clothe in
            return Clothe(id: item.objectID.uriRepresentation(),
                          color: item.color,
                          piece: item.piece,
                          style: item.style,
                          image: item.image)
        }
        return clothes
    }
    
    func fetchAllTrousers() ->[Clothe]? {
        let predicate = NSPredicate(format: "piece == %@", PieceType.trouser.rawValue)
        guard let result = fetchClothes(withPredicate: predicate) else { return nil }
        let clothes = result.map { (item) -> Clothe in
            return Clothe(id: item.objectID.uriRepresentation(),
                          color: item.color,
                          piece: item.piece,
                          style: item.style,
                          image: item.image)
        }
        return clothes
    }
    
    func fetchAllFootwears() ->[Clothe]? {
        let predicate = NSPredicate(format: "piece == %@", PieceType.footwear.rawValue)
        guard let result = fetchClothes(withPredicate: predicate) else { return nil }
        let clothes = result.map { (item) -> Clothe in
            return Clothe(id: item.objectID.uriRepresentation(),
                          color: item.color,
                          piece: item.piece,
                          style: item.style,
                          image: item.image)
        }
        return clothes
    }
    
    func fetchClothe(withId id: URL) -> Clothe? {
        guard let clotheDatabase = fetchDatabaseClothe(withId: id) else { return nil }
        return Clothe(id: clotheDatabase.objectID.uriRepresentation(),
                      color: clotheDatabase.color,
                      piece: clotheDatabase.piece,
                      style: clotheDatabase.style,
                      image: clotheDatabase.image)
    }
    
    func add(_ clothe: Clothe) {
        let clotheDatabase = ClotheDatabase(entity: ClotheDatabase.entity(), insertInto: backgroundContext)
        clotheDatabase.style = clothe.style.rawValue
        clotheDatabase.color = clothe.color
        clotheDatabase.piece = clothe.piece.rawValue
        clotheDatabase.image = clothe.image.jpegData(compressionQuality: 0.75)! as NSData
        clotheDatabase.outfit = nil
        save()
    }
    
    func update(_ clothe: Clothe) {
        guard let clotheDatabase = fetchDatabaseClothe(withId: clothe.id) else { return }
        clotheDatabase.color = clothe.color
        clotheDatabase.piece = clothe.piece.rawValue
        clotheDatabase.style = clothe.style.rawValue
        save()
    }
    
    func remove(_ clothe: Clothe) {
        guard let clotheDatabase = fetchDatabaseClothe(withId: clothe.id) else { return }
        backgroundContext.delete(clotheDatabase)
        save()
    }
    
    private func save() {
        if backgroundContext.hasChanges {
            do{
                try backgroundContext.save()
                NotificationCenter.default.post(name: .coreDataDidSavedClothe,
                                                object: nil,
                                                userInfo: ["saved": true])
            } catch  {
                print("Save Error:\(error)")
                NotificationCenter.default.post(name: .coreDataDidSavedClothe,
                                                object: nil,
                                                userInfo: ["saved": false])
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
    
    private func fetchClothes(withPredicate predicate: NSPredicate) -> [ClotheDatabase]? {
        let request: NSFetchRequest<ClotheDatabase> = ClotheDatabase.fetchRequest()
        request.predicate = predicate
        do{
            return try self.container.viewContext.fetch(request)
        } catch {
            return nil
        }
    }
    
    func fetchDatabaseClothe(withId id: URL) -> ClotheDatabase? {
        guard let managedID = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: id) else {
            return nil
        }
        return try? backgroundContext.existingObject(with: managedID) as? ClotheDatabase
    }
}
