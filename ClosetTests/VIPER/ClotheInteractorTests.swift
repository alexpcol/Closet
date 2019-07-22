//
//  ClotheInteractorTests.swift
//  ClosetTests
//
//  Created by chila on 7/20/19.
//  Copyright © 2019 chila. All rights reserved.
//

import XCTest
@testable import Closet
import CoreData
class ClotheInteractorTests: XCTestCase {

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
        addClotheInteractor = AddClotheInteractor(withContainer: mockPersistentContainer)
        readClotheInteractor = ReadClothesInteractor(withContainer: mockPersistentContainer)
        let clothe = Clothe(color: .red, piece: .top, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        //let clothe2 = Clothe(color: .blue, piece: .trouser, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        addClotheInteractor.add([clothe])
    }
    
    
    func clean() {
        let clothesDatabase = readClotheInteractor.fetchAllClothes()
        if let clothes = clothesDatabase {
            addClotheInteractor.remove(clothes)
        }
    }
    
    func testAddClothe_Add() {
        let clothe = Clothe(color: .blue, piece: .trouser, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        let clothe2 = Clothe(color: .blue, piece: .footwear, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        
        addClotheInteractor.add([clothe, clothe2])
        
        let clothesDatabase = readClotheInteractor.fetchAllClothes()
        if let clothes = clothesDatabase {
            XCTAssertEqual(clothes.count, 3)
        }
    }
    
    func testAddClote_Update() {
        let clothesDatabase = readClotheInteractor.fetchAllClothes()
        if let clothes = clothesDatabase {
            XCTAssertEqual(clothes.count, 1)
            var clothe = clothes[0]
            XCTAssertEqual(clothe.color, UIColor.red)
            clothe.color = UIColor.purple
            addClotheInteractor.update([clothe])
            
            let clothesDatabase = readClotheInteractor.fetchAllClothes()
            if let updatedClothes = clothesDatabase {
                XCTAssertEqual(updatedClothes.count, 1)
                XCTAssertEqual(updatedClothes[0].color, UIColor.purple)
            }
        }
    }
    
    func testAddClothe_RemoveOnlyOne() {
        let clothe = Clothe(color: .blue, piece: .trouser, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        addClotheInteractor.add([clothe])
        
        let clothesDatabase = readClotheInteractor.fetchAllClothes()
        if let clothes = clothesDatabase {
            XCTAssertEqual(clothes.count, 2)
            let clotheToRemove = clothes.filter { (clotheDatabse) -> Bool in
                clotheDatabse.color == .blue
            }
            addClotheInteractor.remove(clotheToRemove)
            
            let upodatedclothesDatabase = readClotheInteractor.fetchAllClothes()
            if let updatedClothes = upodatedclothesDatabase {
                XCTAssertEqual(updatedClothes.count, 1)
                XCTAssertEqual(updatedClothes[0].color, UIColor.red)
            }
        }
        
    }

}
