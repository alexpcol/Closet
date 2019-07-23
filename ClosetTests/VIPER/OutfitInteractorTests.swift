//
//  OutfitInteractor.swift
//  ClosetTests
//
//  Created by chila on 7/22/19.
//  Copyright © 2019 chila. All rights reserved.
//

import XCTest
import CoreData
@testable import Closet

class OutfitInteractor: XCTestCase {
    
    var addOutfitInteractor: AddOutfitInteractor!
    var readOutfitsInteractor: ReadOutfitsInteractor!
    var addClotheInteractor: AddClotheInteractor!
    var readClotheInteractor: ReadClothesInteractor!
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        return NSManagedObjectModel.mergedModel(from: [Bundle(identifier: "com.chila.Closet.copy")!])!
    }()
    lazy var mockPersistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Closet", managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (description, error) in
            precondition(description.type == NSInMemoryStoreType)
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    override func setUp() {
        fullFill()
    }

    override func tearDown() {
        clean()
    }
    
    func fullFill() {
        addOutfitInteractor = AddOutfitInteractor(withContainer: mockPersistentContainer)
        readOutfitsInteractor = ReadOutfitsInteractor(withContainer: mockPersistentContainer)
        addClotheInteractor = AddClotheInteractor(withContainer: mockPersistentContainer)
        readClotheInteractor = ReadClothesInteractor(withContainer: mockPersistentContainer)
        
        let clothe1 = Clothe(id: URL(fileURLWithPath: "lol"), color: .red, piece: .top, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        let clothe2 = Clothe(id: URL(fileURLWithPath: "lol"), color: .green, piece: .trouser, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        let clothe3 = Clothe(id: URL(fileURLWithPath: "lol"), color: .blue, piece: .footwear, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        addClotheInteractor.add([clothe1, clothe2, clothe3])
        
        let result = readClotheInteractor.fetchAllClothes()
        if let clothesDatabase = result {
            let outfit = Outfit(name: "Summer", clothes: clothesDatabase)
            addOutfitInteractor.add([outfit])
        }
    }
    
    func clean() {
        let outfitsDatabase = readOutfitsInteractor.fetchAllOutfits()
        if let outfits = outfitsDatabase {
            addOutfitInteractor.remove(outfits)
        }
    }
    
    func testAddOutfit_Add() {
        
        let clothe1 = Clothe(color: .red, piece: .top, style: .informal, image: UIImage(named: "clothePlaceholder")!)
        let clothe2 = Clothe(color: .green, piece: .trouser, style: .informal, image: UIImage(named: "clothePlaceholder")!)
        let clothe3 = Clothe(color: .blue, piece: .footwear, style: .informal, image: UIImage(named: "clothePlaceholder")!)
        addClotheInteractor.add([clothe1, clothe2, clothe3])
        
        let result = readClotheInteractor.fetchAllClothes()
        if let clothesDatabase = result {
            let outfit = Outfit(name: "Winter", clothes: clothesDatabase)
            addOutfitInteractor.add([outfit])
        }
        
        let outfitsDatabase = readOutfitsInteractor.fetchAllOutfits()
        if let outfits = outfitsDatabase {
            XCTAssertEqual(outfits.count, 2)
        }
    }
    
}
