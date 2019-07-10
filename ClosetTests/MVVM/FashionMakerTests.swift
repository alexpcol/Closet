//
//  FashionMakerTests.swift
//  ClosetTests
//
//  Created by chila on 6/8/19.
//  Copyright © 2019 chila. All rights reserved.
//

import XCTest
import CoreData
@testable import Closet

class FashionMakerTests: XCTestCase {
    var dressMaker: DressMaker!
    var fashionMaker: FashionMaker!
    lazy var managedObjectModel: NSManagedObjectModel = {
        return NSManagedObjectModel.mergedModel(from: [Bundle(identifier: "com.chila.Closet")!])!
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
        super.setUp()
        fullFillFashion()
    }

    override func tearDown() {
        clearFashionMaker()
        super.tearDown()
    }

    func testFetchAllOutfits() {
        let totalOutfits = fashionMaker.fetchAllOutfits()
        XCTAssertEqual(totalOutfits?.count, 1)
    }
    
    func testFetchOutfitById() {
        let totalOutfits = fashionMaker.fetchAllOutfits()!
        let outfit = fashionMaker.fetchOutfit(withId: totalOutfits[0].id)!
        XCTAssertEqual(outfit.name, "Summer")
        XCTAssertEqual(outfit.clothes.count, 3)
    }
    
//    func testRemoveOutfitById() {
//        var totalOutfits = fashionMaker.fetchAllOutfits()!
//        fashionMaker.remove(totalOutfits[0])
//        totalOutfits = fashionMaker.fetchAllOutfits()!
//        XCTAssertEqual(totalOutfits.count, 0)
//    }
    
    func fullFillFashion() {
        dressMaker = DressMaker(container: mockPersistentContainer)
        fashionMaker = FashionMaker(container: mockPersistentContainer)
        var clothes:[NSManagedObject] = []
        for n in 0...3 {
            switch n {
            case 0:
                clothes.append(createClotheDabase(color: UIColor.red, piece: .top, style: .casual))
            case 1:
                clothes.append(createClotheDabase(color: UIColor.red, piece: .top, style: .casual))
            case 2:
                clothes.append(createClotheDabase(color: UIColor.red, piece: .top, style: .casual))
            default:
                print("lol")
                
            }
        }
        createOutfitDabase(name: "Summer", clothes)
        
        try? mockPersistentContainer.viewContext.save()
    }
    
    func createClotheDabase(color: UIColor, piece: PieceType, style: ClotheStyle) -> NSManagedObject {
        let clotheDatabase = NSEntityDescription.insertNewObject(forEntityName: "ClotheDatabase", into: mockPersistentContainer.viewContext)
        clotheDatabase.setValue(color, forKey: "color")
        clotheDatabase.setValue(piece.rawValue, forKey: "piece")
        clotheDatabase.setValue(style.rawValue, forKey: "style")
        clotheDatabase.setValue(UIImage(named: "clothePlaceholder")?.jpegData(compressionQuality: 0.75)!, forKey: "image")
        return clotheDatabase
    }
    
    func createOutfitDabase(name: String,_ clothes: [NSManagedObject]) {
        let outfitDatabase = NSEntityDescription.insertNewObject(forEntityName: "OutfitDatabase", into: mockPersistentContainer.viewContext)
        outfitDatabase.setValue(name, forKey: "name")
        outfitDatabase.setValue(NSSet(array: clothes), forKey: "clothes")
    }
    
    func clearFashionMaker() {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "OutfitDatabase")
        do{
            let result = try self.mockPersistentContainer.viewContext.fetch(request)
            for case let item as NSManagedObject in result {
                mockPersistentContainer.viewContext.delete(item)
            }
            try mockPersistentContainer.viewContext.save()
        } catch {
            print("error")
        }
    }

}
