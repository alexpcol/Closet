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
        fullFill()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func testAddImageFailed() {
        let cameraAccess = FakeCameraAccessFailure()
        var testActions:[UIAlertAction] = []
        let expectation = self.expectation(description: "there is no camera so there are no actions")
        viewModel.addImage(AddClotheViewController(), cameraPermissions: cameraAccess) { (actions) in
            guard let actions = actions else { expectation.fulfill(); return }
            testActions = actions
        }
        waitForExpectations(timeout: 0.3, handler: nil)
        XCTAssertEqual(testActions.count, 0)
    }
    
    func testActionSheetOptions() {
        let cameraAccess = FakeCameraAccessSuccess()
        var testActions:[UIAlertAction] = []
        let expectation = self.expectation(description: "action sheet added")
        viewModel.addImage(AddClotheViewController(), cameraPermissions: cameraAccess) { (actions) in
            guard let actions = actions else { return }
            testActions = actions
            AlertsPresenter.shared.showActionSheet(actions: actions, title: "Test", message: nil, inView: UIViewController())
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.3, handler: nil)
        XCTAssertEqual(testActions.count, 2)
    }
    
    // TODO:- Revisar los titulos de las alertas

    func testClothePieceOptions() {
        XCTAssertEqual(viewModel.pieceName(for: 0), "Para torso", "incorrect top piece picker option")
        XCTAssertEqual(viewModel.pieceName(for: 1), "Para piernas", "incorrect trouser piece picker option")
        XCTAssertEqual(viewModel.pieceName(for: 2), "Para pies", "incorrect footwear piece picker option")
    }

    // Crear una clase que herede de CameraAccess
    func fullFill() {
        viewModel = AddClotheViewMothel()
    }

}
