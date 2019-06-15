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
        dressMaker = DressMaker(container: (UIApplication.shared.delegate as! AppDelegate).persistentContainer)
        dressMaker.add(Clothe.clotheForDressMakerAdd(color: .red, piece: .top, style: .casual))
        dressMaker.add(Clothe.clotheForDressMakerAdd(color: .blue, piece: .trouser, style: .casual))
        dressMaker.add(Clothe.clotheForDressMakerAdd(color: .green, piece: .footwear, style: .casual))
    }
    
    func cleanDressMaker() {
        guard let clothes = dressMaker.fetchAllClothes() else { return }
        for clothe in clothes {
            dressMaker.remove(clothe)
        }
        dressMaker = nil
    }

}
