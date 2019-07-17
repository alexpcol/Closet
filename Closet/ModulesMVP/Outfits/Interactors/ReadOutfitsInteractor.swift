//
//  ReadOutfitsInteractor.swift
//  Closet
//
//  Created by chila on 7/16/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit
import CoreData

class ReadOutfitsInteractor: FashionmakerReadable {
    let fashionMaker: FashionMaker
    
    init(withContainer container: NSPersistentContainer) {
        fashionMaker = FashionMaker(container: container)
    }
    func fetchAllOutfits() -> [Outfit]? {
        let semaforo = DispatchSemaphore(value: 0)
        var outfits:[Outfit]?
        fashionMaker.fetchAllDatabaseOutfit {
            if let outfitsDatabase = $0 {
                outfits = outfitsDatabase.map({ (outfitDatabase) -> Outfit in
                    return Outfit(id: outfitDatabase.objectID.uriRepresentation(), name: outfitDatabase.name, clothes: outfitDatabase.clothes)
                })
                semaforo.signal()
            } else {
                semaforo.signal()
            }
        }
        semaforo.wait()
        return outfits
    }
    
    func fetchOutfit(withId id: URL, completion: @escaping (Outfit?) -> Void) {
        fashionMaker.fetchDatabaseOutfit(withId: id) {
            if let outfitDatabase = $0 {
                let outfit = Outfit(id: outfitDatabase.objectID.uriRepresentation(),
                                    name: outfitDatabase.name,
                                    clothes: outfitDatabase.clothes)
                completion(outfit)
            } else {
                completion(nil)
            }
        }
    }
}
