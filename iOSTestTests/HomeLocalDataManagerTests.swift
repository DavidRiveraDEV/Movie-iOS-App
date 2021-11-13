//
//  HomeLocalDataManagerTests.swift
//  iOSTestTests
//
//  Created by David Rivera on 12/11/21.
//

import XCTest
@testable import iOSTest

class HomeLocalDataManagerTests: XCTestCase {
    
    private var sut: HomeLocalDataManager!
    
    private var popularMoviesExpectation: XCTestExpectation!
    private var topRatedMoviesExpectation: XCTestExpectation!
    private var upcomingMoviesExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        self.sut = HomeLocalDataManager()
        self.sut.dataManagerRequestHandler = self
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }

    func testGetPopularMoviesSuccessful() throws {
        popularMoviesExpectation = expectation(description: "testGetPopularMoviesSuccessful")
        
        self.sut.getPopularMovies()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetTopRatedMoviesSuccessful() throws {
        topRatedMoviesExpectation = expectation(description: "testGetTopRatedMoviesSuccessful")
        
        self.sut.getTopRatedMovies()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetUpcomingMoviesSuccessful() throws {
        upcomingMoviesExpectation = expectation(description: "testGetUpcomingMoviesSuccessful")
        
        self.sut.getUpcomingMovies()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

extension HomeLocalDataManagerTests: HomeDataManagerOutputProtocol {
    
    func onPopularMoviesSuccess(_ moviesResponse: MoviesResponse) {
        XCTAssertNotNil(moviesResponse)
        let movies = moviesResponse.movies
        XCTAssertNotNil(movies)
        XCTAssert(!movies!.isEmpty)
        let movie = movies?[0]
        XCTAssertNotNil(movie)
        XCTAssertNotEqual(movie!.id, 0)
        self.popularMoviesExpectation.fulfill()
    }
    
    func onPopularMoviesError(_ response: FailedResponse) {
        XCTAssert(false)
        self.popularMoviesExpectation.fulfill()
    }
    
    func onTopRatedMoviesSuccess(_ moviesResponse: MoviesResponse) {
        XCTAssertNotNil(moviesResponse)
        let movies = moviesResponse.movies
        XCTAssertNotNil(movies)
        XCTAssert(!movies!.isEmpty)
        let movie = movies?[0]
        XCTAssertNotNil(movie)
        XCTAssertNotEqual(movie!.id, 0)
        topRatedMoviesExpectation.fulfill()
    }
    
    func onTopRatedMoviesError(_ response: FailedResponse) {
        XCTAssert(false)
        topRatedMoviesExpectation.fulfill()
    }
    
    func onUpcomingMoviesSuccess(_ moviesResponse: MoviesResponse) {
        XCTAssertNotNil(moviesResponse)
        let movies = moviesResponse.movies
        XCTAssertNotNil(movies)
        XCTAssert(!movies!.isEmpty)
        let movie = movies?[0]
        XCTAssertNotNil(movie)
        XCTAssertNotEqual(movie!.id, 0)
        upcomingMoviesExpectation.fulfill()
    }
    
    func onUpcomingMoviesError(_ response: FailedResponse) {
        XCTAssert(false)
        upcomingMoviesExpectation.fulfill()
    }
}
