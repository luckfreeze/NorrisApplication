//
//  NorrisAppTests.swift
//  NorrisAppTests
//
//  Created by Lucas Moraes on 20/09/21.
//

import XCTest
@testable import NorrisApp

class NorrisNetworkTest: XCTestCase {
    
    var network: NorrisNetworkType?
    let mock = ResultMock()

    override func setUpWithError() throws {
        super.setUp()
        
        network = NorrisNetwork(sessionConfig: NorrisURLProtocolMock.sessionConfiguration())
    }

    override func tearDownWithError() throws {
        super.tearDown()
        network = nil
        NorrisURLProtocolMock.stubResponseData = nil
        NorrisURLProtocolMock.responseType = .none
    }
   
    
    func testGetCategorySuccess() {
        
        let expectation = self.expectation(description: "test success on getCategory from NorrisNetworkType's protocol")
        let detailString = "Fun"
        
        var data: Data!
        var httpResponse: HTTPURLResponse?
        var error: Error!
        
        
        NorrisURLProtocolMock.responseType = .success
        NorrisURLProtocolMock.stubResponseData = mock.categoryDataSuccess
        
        network?.getCategory(detailString) { d, r, e in
            
            data = d
            httpResponse = r as? HTTPURLResponse
            error = e
            
            expectation.fulfill()    
        }
        
        waitForExpectations(timeout: 1)
        
        let response = try? XCTUnwrap(httpResponse)
        
        XCTAssertEqual(response?.statusCode, 200)
        XCTAssertNotNil(data)
        XCTAssertNil(error)
        
    }
    
    func testGetRandomSuccess() {
        
        let expectation = self.expectation(description: "test success on getRandom from NorrisNetworkType's protocol")

        var data: Data!
        var httpResponse: HTTPURLResponse?
        var error: Error!
        
        NorrisURLProtocolMock.stubResponseData = mock.randomDataSuccess
        NorrisURLProtocolMock.responseType = .success
        network?.getRandom { d, r, e in
            
            data = d
            httpResponse = r as? HTTPURLResponse
            error = e
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)

        let response = try? XCTUnwrap(httpResponse)
        
        XCTAssertNotNil(data)
        XCTAssertEqual(response?.statusCode, 200)
        XCTAssertNil(error)
    }
}
