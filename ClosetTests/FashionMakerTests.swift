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
    
    //TODO: generar un container para las pruebas, no utilizar el que se usa para la app
    
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
        let outfit = fashionMaker.fetchOutfit(withId: totalOutfits[0].id)
        XCTAssertEqual(outfit?.name, "Summer")
    }
    
    func testRemoveOutfitById() {
        var totalOutfits = fashionMaker.fetchAllOutfits()!
        fashionMaker.remove(totalOutfits[0])
        totalOutfits = fashionMaker.fetchAllOutfits()!
        XCTAssertEqual(totalOutfits.count, 0)
    }
    
    func fullFillFashion() {
        dressMaker = DressMaker(container: (UIApplication.shared.delegate as! AppDelegate).persistentContainer)
        fashionMaker = FashionMaker(container: (UIApplication.shared.delegate as! AppDelegate).persistentContainer)
        
        dressMaker.add(Clothe.clotheForDressMakerAdd(color: .red, piece: .top, style: .casual, image: UIImage(named: "clothePlaceholder")!))
        dressMaker.add(Clothe.clotheForDressMakerAdd(color: .green, piece: .trouser, style: .casual, image: UIImage(named: "clothePlaceholder")!))
        dressMaker.add(Clothe.clotheForDressMakerAdd(color: .blue, piece: .footwear, style: .casual, image: UIImage(named: "clothePlaceholder")!))
        
        let clothes = dressMaker.fetchAllClothes()
        
        fashionMaker.add(Outfit.outfitForFashionMakerAdd(name: "Summer", clothes: clothes!))
    }
    
    func clearFashionMaker() {
        guard let outfits = fashionMaker.fetchAllOutfits() else { return }
        for outfit in outfits {
            fashionMaker.remove(outfit)
        }
        guard let clothes = dressMaker.fetchAllClothes() else { return }
        for clothe in clothes {
            dressMaker.remove(clothe)
        }
        dressMaker = nil
        fashionMaker = nil
    }

}
