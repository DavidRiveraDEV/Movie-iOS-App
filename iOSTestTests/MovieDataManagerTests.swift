//
//  MovieDataManagerTests.swift
//  iOSTestTests
//
//  Created by David Rivera on 12/11/21.
//

import XCTest
@testable import iOSTest

class HTTPClientTests: XCTestCase {
    
    private var sut: MovieDataManagerProtocol!

    override func setUp() {
        super.setUp()
//        self.sut = MovieRemoteDataManager()
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func testGetMovieSuccessful() throws {
        let expectation = expectation(description: "testGetMovieSuccessful")
        
        self.sut.getMovie(id: 580489) { (movie: Movie) in
            XCTAssertEqual(movie.id, 580489)
            XCTAssertEqual(movie.title, "Venom: Let There Be Carnage")
            XCTAssertEqual(user.releaseDate, "2021-09-30")
            XCTAssertEqual(user.status, "Released")
            expectation.fulfill()
        } onFailed: { response in
            XCTAssert(false)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetMovieFailed() throws {
        let expectation = expectation(description: "testGetMovieFailed")
        
        self.sut.getMovie(id: 0) { (movie: Movie) in
            XCTAssert(false)
            expectation.fulfill()
        } onFailed: { response in
            XCTAssertEqual(response.statusCode, .notFound)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetPopularMoviesSuccessful() throws {
        let expectation = expectation(description: "testGetPopularMoviesSuccessful")
        
        self.sut.getPopularMovies() { (movies: [Movie]) in
            XCTAssert(!movies.isEmpty)
            let user = users[0]
            XCTAssertNotEqual(user.id, 0)
            expectation.fulfill()
        } onFailed: { response in
            XCTAssert(false)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetPopularMoviesFailed() throws {
        let expectation = expectation(description: "testGetPopularMoviesFailed")
        
        self.sut.getPopularMovies() { (movies: Movie) in
            XCTAssert(false)
            expectation.fulfill()
        } onFailed: { response in
            XCTAssertEqual(response.statusCode, .unprocessableEntity)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
