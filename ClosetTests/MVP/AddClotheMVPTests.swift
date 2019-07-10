//
//  AddClotheMVP.swift
//  ClosetTests
//
//  Created by chila on 7/6/19.
//  Copyright © 2019 chila. All rights reserved.
//

import XCTest
@testable import Closet

class AddClotheMVPTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testViewInit() {
        let addClotheViewMock = AddClotheViewMock()
        let presenter = AddClothePresenter(withDressMaker: DressmakerMock())
        presenter.attach(view: addClotheViewMock)
        wait(for: [addClotheViewMock.expectation], timeout: 0.3)
        XCTAssertEqual(addClotheViewMock.setupTitle, "Nueva")
        XCTAssertEqual(addClotheViewMock.setupNumberOfCalls, 1)
    }
    
    func testSaveClotheSuccess_ToDatabase() {
        let addClotheViewMock = AddClotheViewMock()
        let dressMakerMock = DressmakerMock()
        let presenter = AddClothePresenter(withDressMaker: dressMakerMock)
        presenter.attach(view: addClotheViewMock)
        
        presenter.startEditing(property: .color)
        presenter.startEditing(property: .style)
        presenter.startEditing(property: .piece)
        presenter.didSelect(image: UIImage(named: "clothePlaceholder")!)
        
        addClotheViewMock.save()
        XCTAssertEqual(dressMakerMock.addNumberOfCalls, 1)
    }
    
    func testSaveClotheSuccess_Message() {
        let addClotheViewMock = AddClotheViewMock()
        let dressMakerMock = DressmakerMock()
        let presenter = AddClothePresenter(withDressMaker: dressMakerMock)
        presenter.attach(view: addClotheViewMock)
        
        presenter.startEditing(property: .color)
        presenter.startEditing(property: .style)
        presenter.startEditing(property: .piece)
        presenter.didSelect(image: UIImage(named: "clothePlaceholder")!)
        
        addClotheViewMock.save()
        XCTAssertEqual(addClotheViewMock.saveSuccessMessage, "¡Ropa añadida!")
    }
    
    func testSaveClotheFailure_MissingColor() {
        let addClotheViewMock = AddClotheViewMock()
        let dressMakerMock = DressmakerMock()
        let presenter = AddClothePresenter(withDressMaker: dressMakerMock)
        presenter.attach(view: addClotheViewMock)
    
        presenter.startEditing(property: .style)
        presenter.startEditing(property: .piece)
        presenter.didSelect(image: UIImage(named: "clothePlaceholder")!)
        
        addClotheViewMock.save()
        XCTAssertEqual(addClotheViewMock.saveSuccessMessage, "Verifica tu información")
    }
    
    
}
class AddClotheViewMock: AddClotheViewable {
    // Tenemos la opción de ser el expectation para métodos asincronos o por medio de las siguientes variables
    var expectation = XCTestExpectation(description: "Setup called")
    var setupNumberOfCalls = 0
    var setupTitle = ""
    var saveSuccessMessage = ""
    
    
    private var saveAction: (() -> AlertHeaderModel)?
    
    func showSaveButton(action: @escaping () -> AlertHeaderModel) {
        saveAction = action
    }
    
    func setup(title: String, presenter: AddClothePresentable) {
        setupNumberOfCalls += 1
        setupTitle = title
        expectation.fulfill()
    }
    
    func show(clotheImage: UIImage) {
        print("show")
    }
    
    func showClothe(property: ClotheProperties, withText text: String) {
        
    }
    
    func showPicker(withModel model: PickerOptionsModel) {
        model.didSelectOptionIndex(0)
    }
    
    func save() {
        let headerModel = saveAction?()
        saveSuccessMessage = headerModel!.message
    }
}

class DressmakerMock: DressmakerEditable {
    var addNumberOfCalls = 0
    func add(_ clothe: Clothe) {
        addNumberOfCalls += 1
    }
    
    func update(_ clothe: Clothe) {
        
    }
    
    func remove(_ clothe: Clothe) {
        
    }
    
    
}
