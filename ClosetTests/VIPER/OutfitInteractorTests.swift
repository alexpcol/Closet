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
        return NSManagedObjectModel.mergedModel(from: [Bundle(identifier: "com.chila.Closet.viper")!])!
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
            var clothesForOutfit = [Clothe]()
            for clotheDatabase in clothesDatabase {
                if clotheDatabase.style == .informal {
                    clothesForOutfit.append(clotheDatabase)
                }
            }
            let outfit = Outfit(name: "Winter", clothes: clothesForOutfit)
            addOutfitInteractor.add([outfit])
        }
        
        let outfitsDatabase = readOutfitsInteractor.fetchAllOutfits()
        if let outfits = outfitsDatabase {
            XCTAssertEqual(outfits.count, 2)
        }
    }
    
    func testAddOutfit_UpdateOutfit_Name() {
        let outfitsDatabase = readOutfitsInteractor.fetchAllOutfits()
        if let outfits = outfitsDatabase {
            XCTAssertEqual(outfits.count, 1)
            var outfit = outfits[0]
            XCTAssertEqual(outfit.name, "Summer")
            outfit.name = "Beach"
            addOutfitInteractor.update([outfit])
            let outfitsDatabase = readOutfitsInteractor.fetchAllOutfits()
            if let updatedOutfits = outfitsDatabase {
                XCTAssertEqual(updatedOutfits.count, 1)
                XCTAssertEqual(updatedOutfits[0].name, "Beach")
            }
        }
    }
    
    func testAddOutfit_UpdateOutfit_OneClothe() {
        let outfitsDatabase = readOutfitsInteractor.fetchAllOutfits()
        if let outfits = outfitsDatabase {
            XCTAssertEqual(outfits.count, 1)
            var outfit = outfits[0]
            for (index, clothe) in outfit.clothes.enumerated() {
                if clothe.color == UIColor.red {
                    XCTAssertEqual(clothe.style, ClotheStyle.casual)
                    outfit.clothes[index].style = .informal
                }
            }
            addOutfitInteractor.update([outfit])
            let outfitsDatabase = readOutfitsInteractor.fetchAllOutfits()
            if let updatedOutfits = outfitsDatabase {
                XCTAssertEqual(updatedOutfits.count, 1)
                let outfit = updatedOutfits[0]
                for clothe in outfit.clothes {
                    if clothe.color == UIColor.red {
                        XCTAssertEqual(clothe.style, ClotheStyle.informal)
                    }
                }
            }
        }
    }
    
    func testAddOutfit_UpdateOutfit_AllClothes() {
        let outfitsDatabase = readOutfitsInteractor.fetchAllOutfits()
        if let outfits = outfitsDatabase {
            XCTAssertEqual(outfits.count, 1)
            var outfit = outfits[0]
            for (index, clothe) in outfit.clothes.enumerated() {
                if clothe.color == UIColor.red {
                    XCTAssertEqual(clothe.style, ClotheStyle.casual)
                    outfit.clothes[index].style = .sport
                }
                if clothe.color == UIColor.green {
                    XCTAssertEqual(clothe.piece, PieceType.trouser)
                    outfit.clothes[index].piece = .top
                }
                if clothe.color == UIColor.blue {
                    XCTAssertEqual(clothe.color, UIColor.blue)
                    outfit.clothes[index].color = .brown
                }
            }
            addOutfitInteractor.update([outfit])
            let outfitsDatabase = readOutfitsInteractor.fetchAllOutfits()
            if let updatedOutfits = outfitsDatabase {
                XCTAssertEqual(updatedOutfits.count, 1)
                let outfit = updatedOutfits[0]
                for clothe in outfit.clothes {
                    if clothe.color == UIColor.red {
                        XCTAssertEqual(clothe.style, ClotheStyle.sport)
                    }
                    if clothe.color == UIColor.green {
                        XCTAssertEqual(clothe.piece, PieceType.top)
                    }
                    
                    if clothe.color == UIColor.brown {
                        XCTAssertEqual(clothe.color, UIColor.brown)
                    }
                }
            }
        }
    }
    
    func testAddOutfit_RemoveOutfit() {
        let outfitsDatabase = readOutfitsInteractor.fetchAllOutfits()
        if let outfits = outfitsDatabase {
            XCTAssertEqual(outfits.count, 1)
            addOutfitInteractor.remove(outfits)
            let outfitsDatabase = readOutfitsInteractor.fetchAllOutfits()
            if let updatedOutfits = outfitsDatabase {
                XCTAssertEqual(updatedOutfits.count, 0)
            }
        }
    }
    
    // MARK:- Read Outfit Interactor
    
    func testReadOutfit_FetchAllOutfits() {
        let outfitsDatabase = readOutfitsInteractor.fetchAllOutfits()
        if let outfits = outfitsDatabase {
            XCTAssertEqual(outfits.count, 1)
        }
    }
    
    func testReadOutfit_FetchOutfitByID() {
        let clothe1 = Clothe(color: .red, piece: .top, style: .informal, image: UIImage(named: "clothePlaceholder")!)
        let clothe2 = Clothe(color: .green, piece: .trouser, style: .informal, image: UIImage(named: "clothePlaceholder")!)
        let clothe3 = Clothe(color: .blue, piece: .footwear, style: .informal, image: UIImage(named: "clothePlaceholder")!)
        addClotheInteractor.add([clothe1, clothe2, clothe3])
        
        let result = readClotheInteractor.fetchAllClothes()
        if let clothesDatabase = result {
            var clothesForOutfit = [Clothe]()
            for clotheDatabase in clothesDatabase {
                if clotheDatabase.style == .informal {
                    clothesForOutfit.append(clotheDatabase)
                }
            }
            let outfit = Outfit(name: "Winter", clothes: clothesForOutfit)
            addOutfitInteractor.add([outfit])
        }
        
        let outfitsDatabase = readOutfitsInteractor.fetchAllOutfits()
        if let outfits = outfitsDatabase {
            let outfitDatabase = outfits.first!
            readOutfitsInteractor.fetchOutfit(withId: outfitDatabase.id) { (outfit) in
                XCTAssertEqual(outfit?.name, "Winter")
            }
        }
    }
    
}
