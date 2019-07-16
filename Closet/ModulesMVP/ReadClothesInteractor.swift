//
//  ReadClothesInteractor.swift
//  Closet
//
//  Created by chila on 7/13/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit
import CoreData

class ReadClothesInteractor: DressmakerReadable {
    let dressMaker: DressMaker
    
    init(withContainer container: NSPersistentContainer) {
        dressMaker = DressMaker(container: container)
    }
    
    //    func fetchAllClothes(completion: @escaping ([Clothe]?) -> Void) {
    //        dressMaker.fetchAllClothesDatabase {
    //            if let clothesDatabase = $0 {
    //                let clothes = clothesDatabase.map({ (clotheDatabase) -> Clothe in
    //                    return Clothe(id: clotheDatabase.objectID.uriRepresentation(),
    //                                  color: clotheDatabase.color,
    //                                  piece: clotheDatabase.piece,
    //                                  style: clotheDatabase.style,
    //                                  image: clotheDatabase.image)
    //                })
    //                completion(clothes)
    //            } else {
    //                completion(nil)
    //            }
    //        }
    //    }
    
    func fetchAllClothes() -> [Clothe]? {
        let semaforo = DispatchSemaphore(value: 0)
        var clothes:[Clothe]?
        dressMaker.fetchAllClothesDatabase {
            if let clothesDatabase = $0 {
                clothes = clothesDatabase.map({ (clotheDatabase) -> Clothe in
                    return Clothe(id: clotheDatabase.objectID.uriRepresentation(),
                                  color: clotheDatabase.color,
                                  piece: clotheDatabase.piece,
                                  style: clotheDatabase.style,
                                  image: clotheDatabase.image)
                })
                semaforo.signal()
            } else {
                semaforo.signal()
            }
        }
        semaforo.wait()
        return clothes
    }
    
    func fetchBy(piece: PieceType, completion: @escaping ([Clothe]?) -> Void) {
        let predicate = NSPredicate(format: "piece == %@", piece.rawValue)
        dressMaker.fetchClothesDatabase(withPredicate: predicate) {
            if let clothesDatabase = $0 {
                let clothes = clothesDatabase.map({ (clotheDatabase) -> Clothe in
                    return Clothe(id: clotheDatabase.objectID.uriRepresentation(),
                                  color: clotheDatabase.color,
                                  piece: clotheDatabase.piece,
                                  style: clotheDatabase.style,
                                  image: clotheDatabase.image)
                })
                completion(clothes)
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchClothe(withId id: URL, completion: @escaping (Clothe?) -> Void) {
        dressMaker.fetchDatabaseClothe(withId: id) {
            if let clotheDatabase = $0 {
                let clothe = Clothe(id: clotheDatabase.objectID.uriRepresentation(),
                                    color: clotheDatabase.color,
                                    piece: clotheDatabase.piece,
                                    style: clotheDatabase.style,
                                    image: clotheDatabase.image)
                completion(clothe)
            } else {
                completion(nil)
            }
        }
    }
}
