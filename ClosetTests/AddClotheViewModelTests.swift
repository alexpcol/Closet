//
//  AddClotheViewModelTests.swift
//  ClosetTests
//
//  Created by chila on 6/22/19.
//  Copyright © 2019 chila. All rights reserved.
//

import XCTest
@testable import Closet

class AddClotheViewModelTests: XCTestCase {

    var viewModel: AddClotheViewMothel!
    override func setUp() {
        //fullFill()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        viewModel = nil
    }

//    func testClothePieceOptions() {
//        XCTAssertEqual(viewModel.pieceName(0), "Para torso", "incorrect top piece picker option")
//        XCTAssertEqual(viewModel.pieceName(1), "Para piernas", "incorrect trouser piece picker option")
//        XCTAssertEqual(viewModel.pieceName(2), "Para pies", "incorrect footwear piece picker option")
//    }
//    
//    func testAllPiecesHaveNames() {
//        for (index, element) in PieceType.allCases.enumerated() {
//            XCTAssertNotEqual(viewModel.pieceName(index), "", "There is no name for piece \(element)")
//        }
//    }
//    
//    func testAllStylesHaveNames() {
//        for (index, element) in ClotheStyle.allCases.enumerated() {
//            XCTAssertNotEqual(viewModel.styleName(index), "", "There is no name for style \(element)")
//        }
//    }
//    
//    func testAddImage() {
//        let cameraAccess = FakeCameraAccess()
//        viewModel.addImage(AddClotheViewController(), cameraPermissions: cameraAccess)
//    }
//
//    // Crear una clase que herede de CameraAccess
//    func fullFill() {
//        viewModel = AddClotheViewMothel()
//    }

}
// Es fake para respuestas falsas
//class FakeCameraAccess: CameraAccess {
//    func prepare(inView view: UIViewController) -> Bool {
//        return true
//    }
//}
