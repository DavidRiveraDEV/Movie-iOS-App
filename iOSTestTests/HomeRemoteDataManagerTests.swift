//
//  HomeRemoteDataManagerTests.swift
//  iOSTestTests
//
//  Created by David Rivera on 12/11/21.
//

import XCTest
@testable import iOSTest

class HomeRemoteDataManagerTests: XCTestCase {
    
    private var sut: HomeRemoteDataManager!
    
    private var popularMoviesExpectation: XCTestExpectation!
    private var topRatedMoviesExpectation: XCTestExpectation!
    private var upcomingMoviesExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        self.sut = HomeRemoteDataManager()
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

extension HomeRemoteDataManagerTests: HomeDataManagerOutputProtocol {
    
    func onPopularMoviesSuccess(_ moviesResponse: MoviesResponse) {
        XCTAssertNotNil(moviesResponse)
        let movies = moviesResponse.movies
        XCTAssertNotNil(movies)
        XCTAssert(!movies!.isEmpty)
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
        upcomingMoviesExpectation.fulfill()
    }
    
    func onUpcomingMoviesError(_ response: FailedResponse) {
        XCTAssert(false)
        upcomingMoviesExpectation.fulfill()
    }
}
