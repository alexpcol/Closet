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

protocol FashionmakerReadable {
    func fetchAllOutfits() -> [Outfit]?
    func fetchOutfit(withId id: URL, completion: @escaping (Outfit?) -> Void)
}

protocol FashionmakerEditable {
    func add(_ outfits: [Outfit])
    func update(_ outfits: [Outfit])
    func remove(_ outfits: [Outfit])
}

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
    
    func fetchAllDatabaseOutfit(completion: @escaping ([OutfitDatabase]?) -> Void) {
        let request: NSFetchRequest<OutfitDatabase> = OutfitDatabase.fetchRequest()
        do{
            let outfitsDatabase = try self.container.viewContext.fetch(request)
            completion(outfitsDatabase)
        } catch {
            completion(nil)
        }
    }
    
    func fetchDatabaseOutfit(withId id: URL, completion: @escaping (OutfitDatabase?) -> Void) {
        guard let managedID = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: id) else {
            completion(nil)
            return
        }
        let outfitDatabase = try? backgroundContext.existingObject(with: managedID) as? OutfitDatabase
        completion(outfitDatabase)
    }
    
    func save() {
        if backgroundContext.hasChanges {
            do{
                try backgroundContext.save()
                NotificationCenter.default.post(name: .coreDataDidSavedOutfit,
                                                object: nil,
                                                userInfo: ["saved": true])
            } catch  {
                print("Save Error:\(error)")
                NotificationCenter.default.post(name: .coreDataDidSavedOutfit,
                                                object: nil,
                                                userInfo: ["saved": false])
            }
        }
    }
}
