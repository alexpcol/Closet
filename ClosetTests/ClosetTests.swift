//
//  ClosetTests.swift
//  ClosetTests
//
//  Created by chila on 5/25/19.
//  Copyright © 2019 chila. All rights reserved.
//

import XCTest
import CoreData
@testable import Closet

class ClosetTests: XCTestCase {

    var dressMaker: DressMaker!
    lazy var managedObjectModel: NSManagedObjectModel = {
        return NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
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
        fullFillDressMaker()
    }

    override func tearDown() {
        cleanDressMaker()
        super.tearDown()
    }

    func testFetchAllClothes() {
        let total = dressMaker.fetchAllClothes()!
        XCTAssertEqual(total.count, 3)
    }
    
    func testFetchClotheById() {
        let total = dressMaker.fetchAllClothes()!
        let clothe = dressMaker.fetchClothe(withId: total[0].id)!
        XCTAssertEqual(clothe.color, total[0].color)
        XCTAssertEqual(clothe.piece, total[0].piece)
        XCTAssertEqual(clothe.style, total[0].style)
    }
    
    func testRemoveCloetheById() {
        var total = dressMaker.fetchAllClothes()!
        dressMaker.remove(total[0])
        total = dressMaker.fetchAllClothes()!
        XCTAssertEqual(total.count, 2)
    }
    
    func fullFillDressMaker() {
        dressMaker = DressMaker(container: mockPersistentContainer)
        createClotheDabase(color: .red,
                            piece: .top,
                            style: .casual,
                            image: UIImage(named: "clothePlaceholder")!)
        createClotheDabase(color: .blue,
                            piece: .trouser,
                            style: .casual,
                            image: UIImage(named: "clothePlaceholder")!)
        createClotheDabase(color: .green,
                            piece: .footwear,
                            style: .casual,
                            image: UIImage(named: "clothePlaceholder")!)
        try? mockPersistentContainer.viewContext.save()
    }
    
    func createClotheDabase (color: UIColor, piece: PieceType, style: ClotheStyle, image: UIImage) {
        let clotheDatabase = NSEntityDescription.insertNewObject(forEntityName: "ClotheDatabase", into: mockPersistentContainer.viewContext)
        clotheDatabase.setValue(color, forKey: "color")
        clotheDatabase.setValue(piece.rawValue, forKey: "piece")
        clotheDatabase.setValue(style.rawValue, forKey: "style")
    }
    
    
    func cleanDressMaker() {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "ClotheDatabase")
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
    
//    func cleanDressMaker() {
//        guard let clothes = dressMaker.fetchAllClothes() else { return }
//        for clothe in clothes {
//            dressMaker.remove(clothe)
//        }
//        dressMaker = nil
//    }
    

}
