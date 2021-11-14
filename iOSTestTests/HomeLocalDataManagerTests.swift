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
        self.sut.clearPopularMovies()
        self.sut.clearTopRatedMovies()
        self.sut.clearUpcomingMovies()
        self.sut = nil
        super.tearDown()
    }

    func testGetPopularMoviesSuccessful() throws {
        self.savePopularMovies()
        popularMoviesExpectation = expectation(description: "testGetPopularMoviesSuccessful")
        self.sut.getPopularMovies()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetTopRatedMoviesSuccessful() throws {
        self.saveTopRatedMovies()
        topRatedMoviesExpectation = expectation(description: "testGetTopRatedMoviesSuccessful")
        self.sut.getTopRatedMovies()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetUpcomingMoviesSuccessful() throws {
        self.saveUpcomingMovies()
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
    
    private func savePopularMovies() {
        let venom = Movie()
        venom.id = 580489
        venom.title = "Venom: Let There Be Carnage"
        venom.overview = "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady."
        venom.category = Category.popular.rawValue
        
        let eternals = Movie()
        eternals.id = 524434
        eternals.title = "Eternals"
        eternals.overview = "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants."
        eternals.category = Category.popular.rawValue
        
        let movies = [
            venom,
            eternals
        ]
        _ = self.sut.saveMovies(movies)
    }
    
    private func saveTopRatedMovies() {
        let theShawshankRedemption = Movie()
        theShawshankRedemption.id = 278
        theShawshankRedemption.title = "The Shawshank Redemption"
        theShawshankRedemption.overview = "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope."
        theShawshankRedemption.category = Category.topRated.rawValue
        
        let theGodfather = Movie()
        theGodfather.id = 524434
        theGodfather.title = "The Godfather"
        theGodfather.overview = "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge."
        theGodfather.category = Category.popular.rawValue
        
        let movies = [
            theShawshankRedemption,
            theGodfather
        ]
        _ = self.sut.saveMovies(movies)
    }
    
    private func saveUpcomingMovies() {
        let encanto = Movie()
        encanto.id = 568124
        encanto.title = "Encanto"
        encanto.overview = "The tale of an extraordinary family, the Madrigals, who live hidden in the mountains of Colombia, in a magical house, in a vibrant town, in a wondrous, charmed place called an Encanto. The magic of the Encanto has blessed every child in the family with a unique gift from super strength to the power to heal—every child except one, Mirabel. But when she discovers that the magic surrounding the Encanto is in danger, Mirabel decides that she, the only ordinary Madrigal, might just be her exceptional family's last hope."
        encanto.category = Category.upcoming.rawValue
        
        let demonic = Movie()
        demonic.id = 774021
        demonic.title = "Demonic"
        demonic.overview = "A young woman unleashes terrifying demons when supernatural forces at the root of a decades-old rift between mother and daughter are ruthlessly revealed."
        demonic.category = Category.upcoming.rawValue
        
        let movies = [
            encanto,
            demonic
        ]
        _ = self.sut.saveMovies(movies)
    }
}
