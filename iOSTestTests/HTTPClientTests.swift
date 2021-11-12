//
//  HTTPClientTests.swift
//  iOSTestTests
//
//  Created by David Rivera on 11/11/21.
//

import XCTest
@testable import iOSTest

class HTTPClientTests: XCTestCase {
    
    private var sut: HTTPClient!

    override func setUp() {
        super.setUp()
        let httpService = AlamofireHTTPService()
        self.sut = HTTPClient(baseUrl: "https://jsonplaceholder.typicode.com/", httpService: httpService)
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func testGetUserWithClientServiceSuccessful() throws {
        let expectation = expectation(description: "testGetUserWithClientServiceSuccessful")
        
        self.sut.get(apiPath: "users/1") { (user: User) in
            XCTAssertEqual(user.id, 1)
            XCTAssertEqual(user.name, "Leanne Graham")
            XCTAssertEqual(user.email, "Sincere@april.biz")
            XCTAssertEqual(user.phone, "1-770-736-8031 x56442")
            expectation.fulfill()
        } onFailed: { response in
            XCTAssert(false)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetUserWithClientServiceFailed() throws {
        let expectation = expectation(description: "testGetUserWithClientServiceFailed")
        
        self.sut.get(apiPath: "users/0") { (users: User) in
            XCTAssert(false)
            expectation.fulfill()
        } onFailed: { response in
            XCTAssertEqual(response.statusCode, .notFound)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetUserWithClientServiceFailedCodableError() throws {
        let expectation = expectation(description: "testGetUserWithClientServiceFailedCodableError")
        
        self.sut.get(apiPath: "users/1") { (user: [User]) in
            XCTAssert(false)
            expectation.fulfill()
        } onFailed: { response in
            XCTAssertEqual(response.statusCode, .unprocessableEntity)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetUsersWithClientServiceSuccessful() throws {
        let expectation = expectation(description: "testGetUsersWithClientServiceSuccessful")
        
        self.sut.get(apiPath: "users") { (users: [User]) in
            XCTAssert(!users.isEmpty)
            let user = users[0]
            XCTAssertEqual(user.id, 1)
            XCTAssertEqual(user.name, "Leanne Graham")
            XCTAssertEqual(user.email, "Sincere@april.biz")
            XCTAssertEqual(user.phone, "1-770-736-8031 x56442")
            XCTAssertEqual(users.isEmpty, false)
            expectation.fulfill()
        } onFailed: { response in
            XCTAssert(false)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetUsersWithClientServiceFailed() throws {
        let expectation = expectation(description: "testGetUsersWithClientServiceFailed")
        
        self.sut.get(apiPath: "userz") { (users: [User]) in
            XCTAssert(false)
            expectation.fulfill()
        } onFailed: { response in
            XCTAssertEqual(response.statusCode, .notFound)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetUsersWithClientServiceFailedCodableError() throws {
        let expectation = expectation(description: "testGetUsersWithClientServiceFailedCodableError")
        
        self.sut.get(apiPath: "users") { (user: User) in
            XCTAssert(false)
            expectation.fulfill()
        } onFailed: { response in
            XCTAssertEqual(response.statusCode, .unprocessableEntity)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}

struct User: Codable {
    
    var id: Int16?
    var name: String?
    var email: String?
    var phone: String?
}
