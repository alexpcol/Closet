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
    var addClotheViewMock: AddClotheViewMock!
    var dressMakerMock: DressmakerMock!
    var presenter: AddClothePresenter!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fullFillAddClothe()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cleanAddClothe()
    }
    
    func fullFillAddClothe() {
        addClotheViewMock = AddClotheViewMock()
        dressMakerMock = DressmakerMock()
        presenter = AddClothePresenter(withDressMaker: dressMakerMock)
        presenter.attach(view: addClotheViewMock)
    }
    
    func cleanAddClothe() {
        addClotheViewMock = nil
        dressMakerMock = nil
        presenter = nil
    }

    
    func testViewInit() {
        wait(for: [addClotheViewMock.expectation], timeout: 0.3)
        XCTAssertEqual(addClotheViewMock.setupTitle, "Nueva")
        XCTAssertEqual(addClotheViewMock.setupNumberOfCalls, 1)
    }
    
    func testSaveClotheSuccess_ToDatabase() {
        presenter.startEditing(property: .color)
        presenter.startEditing(property: .style)
        presenter.startEditing(property: .piece)
        presenter.didSelect(image: UIImage(named: "clothePlaceholder")!)
        addClotheViewMock.save()
        XCTAssertEqual(dressMakerMock.addNumberOfCalls, 1)
    }
    
    func testSaveClotheSuccess_Message() {
        presenter.startEditing(property: .color)
        presenter.startEditing(property: .style)
        presenter.startEditing(property: .piece)
        presenter.didSelect(image: UIImage(named: "clothePlaceholder")!)
        
        addClotheViewMock.save()
        XCTAssertEqual(addClotheViewMock.saveSuccessMessage, "¡Ropa añadida!")
    }
    
    func testSaveClotheFailure_MissingColor() {
        presenter.startEditing(property: .style)
        presenter.startEditing(property: .piece)
        presenter.didSelect(image: UIImage(named: "clothePlaceholder")!)
        
        addClotheViewMock.save()
        XCTAssertEqual(addClotheViewMock.saveSuccessMessage, "Verifica tu información")
    }
    
    func testSaveClotheFailure_MissingStyle() {
        presenter.startEditing(property: .color)
        presenter.startEditing(property: .piece)
        presenter.didSelect(image: UIImage(named: "clothePlaceholder")!)
        
        addClotheViewMock.save()
        XCTAssertEqual(addClotheViewMock.saveSuccessMessage, "Verifica tu información")
    }
    
    func testSaveClotheFailure_MissingPiece() {
        presenter.startEditing(property: .color)
        presenter.startEditing(property: .style)
        presenter.didSelect(image: UIImage(named: "clothePlaceholder")!)
        
        addClotheViewMock.save()
        XCTAssertEqual(addClotheViewMock.saveSuccessMessage, "Verifica tu información")
    }
    
    func testSaveClotheFailure_MissingImage() {
        presenter.startEditing(property: .color)
        presenter.startEditing(property: .piece)
        presenter.startEditing(property: .style)
        
        addClotheViewMock.save()
        XCTAssertEqual(addClotheViewMock.saveSuccessMessage, "Verifica tu información")
    }
    
    func testPickerOptions_ForColors() {
        presenter.startEditing(property: .color)
        XCTAssertEqual(addClotheViewMock.pickerOptions, ["Rojo", "Verde", "Azul"])
    }
    
    func testImageSelected() {
        presenter.didSelect(image: UIImage(named: "clothePlaceholder")!)
        XCTAssertNotNil(addClotheViewMock.imageSelected)
    }
    
    func testGetNoMediaOptionsForImagesInSimulator() {
        presenter.prepareMediaOptions(in: UIViewController(), withCameraPersmissions: Camera.shared) { (actions) in
            guard let realActions = actions else { XCTAssertNil(actions); return }
            print(realActions)
        }
    }
    
}
class AddClotheViewMock: AddClotheViewable {
    // Tenemos la opción de ser el expectation para métodos asincronos o por medio de las siguientes variables
    var expectation = XCTestExpectation(description: "Setup called")
    var setupNumberOfCalls = 0
    var setupTitle = ""
    var saveSuccessMessage = ""
    var pickerOptions = [String]()
    var imageSelected: UIImage?
    
    
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
        imageSelected = clotheImage
    }
    
    func showClothe(property: ClotheProperties, withText text: String) {
        print(property)
    }
    
    func showPicker(withModel model: PickerOptionsModel) {
        pickerOptions = model.options
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
