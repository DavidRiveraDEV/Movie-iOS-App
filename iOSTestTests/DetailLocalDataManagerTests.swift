//
//  DetailLocalDataManagerTests.swift
//  iOSTestTests
//
//  Created by David Rivera on 15/11/21.
//

import XCTest
@testable import iOSTest

class DetailLocalDataManagerTests: XCTestCase {
    
    private var sut: DetailLocalDataManagerInputProtocol!
    private var localMovieService: LocalMovieService!
    
    private var movieExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        self.sut = DetailLocalDataManager()
        self.sut.dataManagerRequestHandler = self
        self.localMovieService = LocalMovieService()
    }

    override func tearDown() {
        self.localMovieService.clearMovie(id: 580489)
        self.sut = nil
        super.tearDown()
    }

    func testGetMovieSuccessful() throws {
        self.saveMovie()
        movieExpectation = expectation(description: "testGetMovieSuccessful")
        self.sut.getMovie(id: 580489)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    private func saveMovie() {
        let venom = Movie()
        venom.id = 580489
        venom.title = "Venom: Let There Be Carnage"
        venom.overview = "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady."
        venom.category = Category.popular.rawValue
    
        _ = self.localMovieService.saveMovie(venom)
    }
}

extension DetailLocalDataManagerTests: DetailLocalDataManagerOutputProtocol {
    
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
