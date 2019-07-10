//
//  AddOutfitMVPTests.swift
//  ClosetTests
//
//  Created by chila on 7/10/19.
//  Copyright © 2019 chila. All rights reserved.
//

import XCTest
@testable import Closet

class AddOutfitMVPTests: XCTestCase {

    var addOutfitViewMock: AddOutfitViewMock!
    var fashionmakerMock: FashionmakerMock!
    var presenter: AddOutfitPresenter!
    
    override func setUp() {
        fullFillAddOutfit()
    }

    override func tearDown() {
        cleanAddOutfit()
    }
    
    func fullFillAddOutfit() {
        let coordinador = OutfitsCoordinator(navigationController: UINavigationController())
        addOutfitViewMock = AddOutfitViewMock()
        fashionmakerMock = FashionmakerMock()
        presenter = AddOutfitPresenter(withFashionMaker: fashionmakerMock!, coordinator: coordinador)
        presenter.attach(view: addOutfitViewMock)
    }
    
    func cleanAddOutfit() {
        addOutfitViewMock = nil
        fashionmakerMock = nil
        presenter = nil
    }
    
    func testViewInit() {
        presenter.attach(view: addOutfitViewMock)
        wait(for: [addOutfitViewMock.expectation], timeout: 0.3)
        XCTAssertEqual(addOutfitViewMock.setupTitle, "Nuevo")
        XCTAssertEqual(addOutfitViewMock.numberOfSetupCalls, 2)
    }
    
    func testSaveOutfitSuccess() {
        presenter.startEditing(name: "Summer")
        presenter.startEditing(pieceType: .top)
        presenter.topClothe = Clothe(color: .red, piece: .top, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        presenter.trouserClothe = Clothe(color: .red, piece: .trouser, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        presenter.footwearClothe = Clothe(color: .red, piece: .footwear, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        addOutfitViewMock.save()
        XCTAssertEqual(fashionmakerMock.addNumberOfCalls, 1)
    }
    
    func testSaveOutfitFailure_MissingOutfitName() {
        presenter.topClothe = Clothe(color: .red, piece: .top, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        presenter.trouserClothe = Clothe(color: .red, piece: .trouser, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        presenter.footwearClothe = Clothe(color: .red, piece: .footwear, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        addOutfitViewMock.save()
        XCTAssertEqual(addOutfitViewMock.saveSuccessMessage, "Verifica tu información")
    }
    
    func testSaveOutfitFailure_MissingOutfitTop() {
        presenter.startEditing(name: "Summer")
        presenter.trouserClothe = Clothe(color: .red, piece: .trouser, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        presenter.footwearClothe = Clothe(color: .red, piece: .footwear, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        addOutfitViewMock.save()
        XCTAssertEqual(addOutfitViewMock.saveSuccessMessage, "Verifica tu información")
    }
    
    func testSaveOutfitFailure_MissingOutfitTrouser() {
        presenter.startEditing(name: "Summer")
        presenter.topClothe = Clothe(color: .red, piece: .top, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        presenter.footwearClothe = Clothe(color: .red, piece: .footwear, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        addOutfitViewMock.save()
        XCTAssertEqual(addOutfitViewMock.saveSuccessMessage, "Verifica tu información")
    }
    
    func testSaveOutfitFailure_MissingOutfitFootwear() {
        presenter.startEditing(name: "Summer")
        presenter.topClothe = Clothe(color: .red, piece: .top, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        presenter.trouserClothe = Clothe(color: .red, piece: .trouser, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        addOutfitViewMock.save()
        XCTAssertEqual(addOutfitViewMock.saveSuccessMessage, "Verifica tu información")
    }
}

class AddOutfitViewMock: AddOutfitViewable {
    var expectation = XCTestExpectation(description: "Setup called")
    var numberOfSetupCalls = 0
    var setupTitle = ""
    var saveSuccessMessage = ""
    private var saveAction: (() -> AlertHeaderModel)?
    
    func setup(title: String, presenter: AddOutfitPresentable) {
        numberOfSetupCalls += 1
        setupTitle = title
        expectation.fulfill()
    }
    
    func showSaveButton(action: @escaping () -> AlertHeaderModel) {
        saveAction = action
    }
    
    func show(clothe: Clothe, forPieceType type: PieceType) {
        print(clothe)
    }
    
    func save() {
        let headerModel = saveAction?()
        saveSuccessMessage = headerModel!.message
    }
}

class FashionmakerMock: FashionmakerEditable {
    var addNumberOfCalls = 0
    func add(_ outfit: Outfit) {
        addNumberOfCalls += 1
    }
    
    func update(_ outfit: Outfit) {
        print(outfit)
    }
    
    func remove(_ outfit: Outfit) {
        print(outfit)
    }
}
