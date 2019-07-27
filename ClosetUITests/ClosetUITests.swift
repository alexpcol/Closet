//
//  ClosetUITests.swift
//  ClosetUITests
//
//  Created by chila on 7/27/19.
//  Copyright © 2019 chila. All rights reserved.
//

import XCTest

class ClosetUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddClothePickers() {
        let app = XCUIApplication()
        app.navigationBars["Ropa"].buttons["Add"].tap()
        
        let app2 = app
        let colorButton = app.buttons["colorButton"]
        let pieceButton = app.buttons["pieceButton"]
        let styleButton = app.buttons["styleButton"]
        
        colorButton.tap()
        app2/*@START_MENU_TOKEN@*/.pickerWheels["Rojo"].tap()/*[[".pickers.pickerWheels[\"Rojo\"]",".tap()",".press(forDuration: 0.5);",".pickerWheels[\"Rojo\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,1]]@END_MENU_TOKEN@*/
        
        let okButton = app.toolbars["Toolbar"].buttons["   OK"]
        okButton.tap()
        pieceButton.tap()
        app2/*@START_MENU_TOKEN@*/.pickerWheels["Para torso"].tap()/*[[".pickers.pickerWheels[\"Para torso\"]",".tap()",".press(forDuration: 0.7);",".pickerWheels[\"Para torso\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,1]]@END_MENU_TOKEN@*/
        okButton.tap()
        styleButton.tap()
        app2/*@START_MENU_TOKEN@*/.pickerWheels["Estilo casual👕"]/*[[".pickers.pickerWheels[\"Estilo casual👕\"]",".pickerWheels[\"Estilo casual👕\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        okButton.tap()
        
        let colorTextfield = app.textFields["colorTextfield"]
        let pieceTextfield = app.textFields["pieceTextfield"]
        let styleTextfield = app.textFields["styleTextfield"]
        
        print(colorTextfield.value as! String)
        
        XCTAssertEqual(colorTextfield.value as! String, "Rojo")
        XCTAssertEqual(pieceTextfield.value as! String, "Para torso")
        XCTAssertEqual(styleTextfield.value as! String, "Estilo casual👕")
    }
    
    
    func testAddClothe() {
        let app = XCUIApplication()
        app.navigationBars["Ropa"].buttons["Add"].tap()
        let app2 = app
        let colorButton = app.buttons["colorButton"]
        let pieceButton = app.buttons["pieceButton"]
        let styleButton = app.buttons["styleButton"]
        
        colorButton.tap()
        app2/*@START_MENU_TOKEN@*/.pickerWheels["Rojo"].tap()/*[[".pickers.pickerWheels[\"Rojo\"]",".tap()",".press(forDuration: 0.5);",".pickerWheels[\"Rojo\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,1]]@END_MENU_TOKEN@*/
        
        let okButton = app.toolbars["Toolbar"].buttons["   OK"]
        okButton.tap()
        pieceButton.tap()
        app2/*@START_MENU_TOKEN@*/.pickerWheels["Para torso"].tap()/*[[".pickers.pickerWheels[\"Para torso\"]",".tap()",".press(forDuration: 0.7);",".pickerWheels[\"Para torso\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,1]]@END_MENU_TOKEN@*/
        okButton.tap()
        styleButton.tap()
        app2/*@START_MENU_TOKEN@*/.pickerWheels["Estilo casual👕"]/*[[".pickers.pickerWheels[\"Estilo casual👕\"]",".pickerWheels[\"Estilo casual👕\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        okButton.tap()
        
        let addImageButton = app.buttons["addImageButton"]
        addImageButton.tap()
        if app.sheets["Media"].buttons["Galería"].waitForExistence(timeout: 2) {
            app.sheets["Media"].buttons["Galería"].tap()
            if app.navigationBars["Photos"].waitForExistence(timeout: 3) {
                //app.tables.cells.element(boundBy: 0).tap()
                app.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0)).withOffset(CGVector(dx: 5, dy: 100)).tap()
                app.collectionViews["PhotosGridView"].cells.element(boundBy: 3).tap()
                
            }
        }
        app.navigationBars["Nueva"].buttons["Add"].tap()
        app.alerts["Closet"].buttons["ok"].tap()
        
    }
    
    func testAddOutfit() {
        let app = XCUIApplication()
        app.tabBars.buttons["Outfits"].tap()
        app.navigationBars["Outfits"].buttons["Add"].tap()
        
        let nameTextfield = app.textFields["nameTextfield"]
        nameTextfield.tap()
        nameTextfield.typeText("hola")
        
        let pieceTopButton = app.buttons["pieceTopButton"]
        let pieceTrouserButton = app.buttons["pieceTrouserButton"]
        let pieceFootwearButton = app.buttons["pieceFootwearButton"]
        pieceTopButton.tap()
        
        let element = app.collectionViews.cells.element(boundBy: 0)
        element.tap()
        
        pieceTrouserButton.tap()
        app.collectionViews.cells.element(boundBy: 1).tap()
        //element.tap()
        
        pieceFootwearButton.tap()
        element.tap()
        
        app.navigationBars["Nuevo"].buttons["Add"].tap()
        app.alerts["Closet"].buttons["ok"].tap()
        XCTAssertTrue(app.otherElements["OutfitViewControllerMVP"].waitForExistence(timeout: 2))
    }

}
