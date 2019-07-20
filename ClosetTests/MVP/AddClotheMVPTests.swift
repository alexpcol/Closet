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
    //Variables for presenter Tests
    var addClotheViewMock: AddClotheViewMock!
    var dressMakerMock: DressmakerMock!
    var presenter: AddClothePresenter!
    
    //Variables for View Tests
    var addClotheView: AddClotheViewControllerMVP!
    var presenterMock: AddClothePresenterMock!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fullFillAddClothePresenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cleanAddClothePresenter()
    }
    
    func fullFillAddClothePresenter() {
        addClotheViewMock = AddClotheViewMock()
        addClotheView = AddClotheViewControllerMVP()
        dressMakerMock = DressmakerMock()
        presenter = AddClothePresenter(withDressMaker: dressMakerMock)
        presenter.attach(view: addClotheViewMock)
    }
    
    func cleanAddClothePresenter() {
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
    
    func testSaveClotheSuccess_Message_CloseView() {
        presenter.startEditing(property: .color)
        presenter.startEditing(property: .style)
        presenter.startEditing(property: .piece)
        presenter.didSelect(image: UIImage(named: "clothePlaceholder")!)
        
        addClotheViewMock.save()
        XCTAssertEqual(addClotheViewMock.saveSuccessMessage, "¡Ropa añadida!")
        XCTAssertEqual(addClotheViewMock.closeViewNumberOfCalls, 1)

    }
    
    func testSaveClotheFailure_MissingColor_CloseView() {
        presenter.startEditing(property: .style)
        presenter.startEditing(property: .piece)
        presenter.didSelect(image: UIImage(named: "clothePlaceholder")!)
        
        addClotheViewMock.save()
        XCTAssertEqual(addClotheViewMock.saveSuccessMessage, "Verifica tu información")
        XCTAssertEqual(addClotheViewMock.closeViewNumberOfCalls, 0)
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
    
    func testGetMediaOptionsForImages_Failure() {
        presenter.prepareMediaOptions(in: addClotheView, withCameraPersmissions: FakeCameraAccessFailure() as CameraAccess) { (actions) in
            guard let realActions = actions else { XCTAssertNil(actions); return }
            print(realActions)
        }
    }
    
    func testGetMediaOptionsForImages() {
        presenter.prepareMediaOptions(in: addClotheView, withCameraPersmissions: FakeCameraAccessSuccess() as CameraAccess) { (actions) in
            guard let realActions = actions else { return }
            XCTAssertEqual(realActions.count, 2)
        }
    }
}
//MARK:- ViewControllers no crearlos en las pruebas

class AddClotheViewMock: AddClotheViewable {
    // Tenemos la opción de ser el expectation para métodos asincronos o por medio de las siguientes variables
    var expectation = XCTestExpectation(description: "Setup called")
    var setupNumberOfCalls = 0
    var setupTitle = ""
    var saveSuccessMessage = ""
    var pickerOptions = [String]()
    var imageSelected: UIImage?
    var closeViewNumberOfCalls = 0
    
    
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
    
    func closeView() {
        closeViewNumberOfCalls += 1
    }
    
    func save() {
        let headerModel = saveAction?()
        headerModel?.action?()
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

class AddClothePresenterMock: AddClothePresentable {
    
    private weak var view: AddClotheViewable?
    func attach(view: AddClotheViewable) {
        self.view = view
        self.view?.setup(title: "Nueva", presenter: self as AddClothePresentable)
        self.view?.showSaveButton(action: {
            self.getAlertHeaderModel()
        })
    }
    
    func startEditing(property: ClotheProperties) {
        var options = [String]()
        var handler: (Int) -> Void
        switch property {
        case .color:
            options = ["Rojo","Azul"]
            handler = { (index) in
                self.view?.showClothe(property: property, withText: options[index])
            }
        case .piece:
            options = ["Torso","Piernas"]
            handler = { (index) in
                self.view?.showClothe(property: property, withText: options[index])
            }
        case .style:
            options = ["Casual","Informal"]
            handler = { (index) in
                self.view?.showClothe(property: property, withText: options[index])
            }
        }
        
        view?.showPicker(withModel: PickerOptionsModel(options: options, didSelectOptionIndex: handler))
    }
    
    func prepareMediaOptions(in view: UIViewController, withCameraPersmissions cameraPermissions: CameraAccess, _ completionHandler: @escaping ([UIAlertAction]?) -> Void) {
        print(cameraPermissions)
    }
    
    func didSelect(image: UIImage) {
        print(image)
    }
    
    private func getAlertHeaderModel() -> AlertHeaderModel {
        return AlertHeaderModel(title: "Alerta", message: "mensaje de alerta")
    }
}
