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

protocol DressmakerReadable {
    func fetchAllClothes() -> [Clothe]?
    func fetchBy(piece: PieceType, completion: @escaping ([Clothe]?) -> Void)
    func fetchClothe(withId id: URL, completion: @escaping (Clothe?) -> Void)
}

protocol DressmakerEditable {
    func add(_ clothes: [Clothe])
    func update(_ clothes: [Clothe])
    func remove(_ clothes: [Clothe])
}

class DressMaker {
    private let container: NSPersistentContainer
    lazy var backgroundContext: NSManagedObjectContext = {
        return container.viewContext
    }()
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func fetchDatabaseClothe(withId id: URL,  completion: @escaping (ClotheDatabase?) -> Void) {
        guard let managedID = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: id) else {
            completion(nil)
            return
        }
        let clotheDatabase = try? backgroundContext.existingObject(with: managedID) as? ClotheDatabase
        completion(clotheDatabase)
    }
    
    func fetchAllClothesDatabase(completion: @escaping ([ClotheDatabase]?) -> Void) {
        let request: NSFetchRequest<ClotheDatabase> = ClotheDatabase.fetchRequest()
        do{
            let clothesDatabase = try self.container.viewContext.fetch(request)
            completion(clothesDatabase)
        } catch {
            completion(nil)
            return
        }
    }
    
    func fetchClothesDatabase(withPredicate predicate: NSPredicate, completion: @escaping ([ClotheDatabase]?) -> Void) {
        let request: NSFetchRequest<ClotheDatabase> = ClotheDatabase.fetchRequest()
        request.predicate = predicate
        do{
            let clothesDatabase = try self.container.viewContext.fetch(request)
            completion(clothesDatabase)
        } catch {
            completion(nil)
            return
        }
    }
    
    func save() {
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
}
