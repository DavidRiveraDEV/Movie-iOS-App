//
//  DetailRemoteDataManagerTests.swift
//  iOSTestTests
//
//  Created by David Rivera on 15/11/21.
//

import XCTest
@testable import iOSTest

class DetailRemoteDataManagerTests: XCTestCase {
    
    private var sut: DetailRemoteDataManagerInputProtocol!
    
    private var movieExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        self.sut = DetailRemoteDataManager()
        self.sut.dataManagerRequestHandler = self
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }

    func testGetMovieSuccessful() throws {
        movieExpectation = expectation(description: "testGetMovieSuccessful")
        
        self.sut.getMovie(id: 580489)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

extension DetailRemoteDataManagerTests: DetailRemoteDataManagerOutputProtocol {
    
    func onMovieSuccess(_ movieResponse: Movie) {
        XCTAssertNotNil(movieResponse)
        XCTAssertEqual(movieResponse.id, 580489)
        XCTAssertEqual(movieResponse.title, "Venom: Let There Be Carnage")
        self.movieExpectation.fulfill()
    }
    
    func onMovieError(_ response: FailedResponse) {
        XCTAssert(false)
        self.movieExpectation.fulfill()
    }
}
