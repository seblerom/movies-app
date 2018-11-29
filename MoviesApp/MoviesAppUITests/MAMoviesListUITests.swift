//
//  MAMoviesListUITests.swift
//  MoviesAppUITests
//
//  Created by Sebastian Leon on 22/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import XCTest
@testable import MoviesApp

class MAMoviesListUITests: XCTestCase {
    
    var app:XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        app.launchArguments.append("--uitestings")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGoingToDetailAndBack() {
        let collectionView = app.collectionViews
        collectionView.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        let detailNavBar = app.navigationBars["Movie Details"]
        XCTAssert(detailNavBar.exists,"Movies navbar does not exist")
        detailNavBar.buttons["Movies"].tap()
        let moviesNavBar = app.navigationBars["Movies"]
        XCTAssert(moviesNavBar.exists,"Movies detail navbar does not exist")
    }
    
    func testSwipeDown() {
        let collectionView = app.collectionViews.element(boundBy: 0)
        let lastCell = collectionView.cells.element(boundBy: collectionView.cells.count - 1)
        collectionView.scrollToElement(lastCell)
    }
    
    func testSwipeDownAndUpAgain() {
        let collectionView = app.collectionViews.element(boundBy: 0)
        let lastCell = collectionView.cells.element(boundBy: collectionView.cells.count - 1)
        collectionView.scrollToElement(lastCell)
        collectionView.cells.element(boundBy: 0).swipeDown()
    }
    
}


extension XCUIElement {
    func scrollToElement(_ element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
