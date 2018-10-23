//
//  MANetworkClientTest.swift
//  MoviesAppTests
//
//  Created by Sebastian Leon on 22/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import XCTest
@testable import MoviesApp

class MANetworkClientTest: XCTestCase {
    
    var moviesListController : MAMoviesListViewController!
    var moviesListPresenter : MAMoviesListPresenter!
    
    override func setUp() {
        moviesListController = MAMoviesListViewController()
        moviesListPresenter = moviesListController.presenter
    }

    override func tearDown() {}

    func testConfigurationRequest() {
        
        let view = moviesListController.view
        XCTAssert(view != nil,"ViewController view is nil")
        
        moviesListPresenter.loadConfiguration()
        
        let expectation = XCTestExpectation(description: "Load configuration")
        _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        let config2 = moviesListPresenter.configuration
        guard let _ = config2 else{
            XCTAssert(false,"Loading configuration did not succeed")
            return
        }
        
    }
    
    func testLoadMovies() {
        
        let view = moviesListController.view
        XCTAssert(view != nil,"ViewController view is nil")
        
        moviesListPresenter.loadMovies()
        
        let expectation = XCTestExpectation(description: "Load movies")
        _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        let movies = moviesListPresenter.moviesModel
        guard let _ = movies else{
            XCTAssert(false,"Loading movies did not succeed")
            return
        }
        
    }
    
    func testFilterSuccess() {
        
        let view = moviesListController.view
        XCTAssert(view != nil,"ViewController view is nil")
        
        moviesListPresenter.filterContent("Avengers")
        
        let expectation = XCTestExpectation(description: "Filter returns results")
        _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        
        guard let _ = moviesListPresenter.filteredMoviesModel else{
            XCTAssert(false,"Loading movies from filter did not succeed")
            return
        }
        
    }
    
    func testFilterFail() {
        
        let view = moviesListController.view
        XCTAssert(view != nil,"ViewController view is nil")
        
        moviesListPresenter.filterContent("asdfasdfasdfasd")
        
        let expectation = XCTestExpectation(description: "Filter doesn't returns results")
        _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        
        if let results = moviesListPresenter.filteredMoviesModel?.results,!results.isEmpty {
            XCTAssert(false,"Loading movies from filter return results")
        }
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
