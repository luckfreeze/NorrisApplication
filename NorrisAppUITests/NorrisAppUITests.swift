//
//  NorrisAppUITests.swift
//  NorrisAppUITests
//
//  Created by Lucas Vinicius S. Corrêa de Moraes on 21/10/21.
//

import XCTest

class NorrisAppUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        super.setUp()
        
        continueAfterFailure = false
        
        /** launchArguments for offline testing with mocked data */
//        app.launchArguments = ["-isStagingOfflineRunning"]
        app.launch()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testViewDetail() {
        
        let animalCell = app.tables/*@START_MENU_TOKEN@*/.staticTexts["animal"]/*[[".cells.staticTexts[\"animal\"]",".staticTexts[\"animal\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssert(animalCell.waitForExistence(timeout: 4))
        XCTAssertTrue(animalCell.exists)
        
        animalCell.tap()
        
        let detailTitle = app.navigationBars["animal"]
        
        XCTAssert(detailTitle.waitForExistence(timeout: 4))
        XCTAssertTrue(detailTitle.exists)
    }
    
    func testViewDetailAndGoBack() {
        
        let animalCell = app.tables.staticTexts["fashion"]
        XCTAssert(animalCell.waitForExistence(timeout: 4))
        animalCell.tap()
        
        let detailTitle = app.navigationBars["fashion"]
        XCTAssert(detailTitle.waitForExistence(timeout: 4))

        
        let navBarButton = app.navigationBars["fashion"].buttons["Categories"]
        navBarButton.tap()
        
        XCTAssert(app.navigationBars["Categories"].exists)
    }
}
