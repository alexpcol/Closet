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
    
    func fullFillFashion() {
        dressMaker = DressMaker(container: (UIApplication.shared.delegate as! AppDelegate).persistentContainer)
        fashionMaker = FashionMaker(container: (UIApplication.shared.delegate as! AppDelegate).persistentContainer)
        
        dressMaker.add(Clothe.clotheForDressMakerAdd(color: .red, piece: .top, style: .casual))
        dressMaker.add(Clothe.clotheForDressMakerAdd(color: .green, piece: .trouser, style: .casual))
        dressMaker.add(Clothe.clotheForDressMakerAdd(color: .blue, piece: .footwear, style: .casual))
        
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
