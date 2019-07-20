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
        XCTAssertEqual(addOutfitViewMock.setupNumberOfCalls, 2)
    }
    
    func testSaveOutfitSuccess_CloseView() {
        presenter.startEditing(name: "Summer")
        presenter.startEditing(pieceType: .top)
        let topClothe = Clothe(color: .red, piece: .top, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        let trouserClothe = Clothe(color: .red, piece: .trouser, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        let footwearClothe = Clothe(color: .red, piece: .footwear, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        presenter.didSelectClothe(topClothe, forPieceType: .top)
        presenter.didSelectClothe(trouserClothe, forPieceType: .trouser)
        presenter.didSelectClothe(footwearClothe, forPieceType: .footwear)
        addOutfitViewMock.save()
        XCTAssertEqual(fashionmakerMock.addNumberOfCalls, 1)
        XCTAssertEqual(addOutfitViewMock.closeViewNumberOfcalls, 1)
    }
    
    func testSaveOutfitFailure_MissingOutfitName_NotCloseView() {
        let topClothe = Clothe(color: .red, piece: .top, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        let trouserClothe = Clothe(color: .red, piece: .trouser, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        let footwearClothe = Clothe(color: .red, piece: .footwear, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        presenter.didSelectClothe(topClothe, forPieceType: .top)
        presenter.didSelectClothe(trouserClothe, forPieceType: .trouser)
        presenter.didSelectClothe(footwearClothe, forPieceType: .footwear)
        addOutfitViewMock.save()
        XCTAssertEqual(addOutfitViewMock.saveSuccessMessage, "Verifica tu información")
        XCTAssertEqual(addOutfitViewMock.closeViewNumberOfcalls, 0)
    }
    
    func testSaveOutfitFailure_MissingOutfitTop() {
        presenter.startEditing(name: "Summer")
        let trouserClothe = Clothe(color: .red, piece: .trouser, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        let footwearClothe = Clothe(color: .red, piece: .footwear, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        presenter.didSelectClothe(trouserClothe, forPieceType: .trouser)
        presenter.didSelectClothe(footwearClothe, forPieceType: .footwear)
        addOutfitViewMock.save()
        XCTAssertEqual(addOutfitViewMock.saveSuccessMessage, "Verifica tu información")
    }
    
    func testSaveOutfitFailure_MissingOutfitTrouser() {
        presenter.startEditing(name: "Summer")
        let topClothe = Clothe(color: .red, piece: .top, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        let footwearClothe = Clothe(color: .red, piece: .footwear, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        presenter.didSelectClothe(topClothe, forPieceType: .top)
        presenter.didSelectClothe(footwearClothe, forPieceType: .footwear)
        addOutfitViewMock.save()
        XCTAssertEqual(addOutfitViewMock.saveSuccessMessage, "Verifica tu información")
    }
    
    func testSaveOutfitFailure_MissingOutfitFootwear() {
        presenter.startEditing(name: "Summer")
        let topClothe = Clothe(color: .red, piece: .top, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        let trouserClothe = Clothe(color: .red, piece: .trouser, style: .casual, image: UIImage(named: "clothePlaceholder")!)
        presenter.didSelectClothe(topClothe, forPieceType: .top)
        presenter.didSelectClothe(trouserClothe, forPieceType: .trouser)
        addOutfitViewMock.save()
        XCTAssertEqual(addOutfitViewMock.saveSuccessMessage, "Verifica tu información")
    }
}

class AddOutfitViewMock: AddOutfitViewable {
    
    var expectation = XCTestExpectation(description: "Setup called")
    var setupNumberOfCalls = 0
    var setupTitle = ""
    var saveSuccessMessage = ""
    var closeViewNumberOfcalls = 0
    var show_clotheSelected: Clothe?
    var show_pieceType: PieceType?
    private var saveAction: (() -> AlertHeaderModel)?
    
    func setup(title: String, presenter: AddOutfitPresentable) {
        setupNumberOfCalls += 1
        setupTitle = title
        expectation.fulfill()
    }
    
    func showSaveButton(action: @escaping () -> AlertHeaderModel) {
        saveAction = action
    }
    
    func show(clothe: Clothe, forPieceType type: PieceType) {
        show_clotheSelected = clothe
        show_pieceType = type
    }
    
    func closeView() {
        closeViewNumberOfcalls += 1
    }
    
    func save() {
        let headerModel = saveAction?()
        headerModel?.action?()
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

