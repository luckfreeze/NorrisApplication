//
//  NorrisBusinessTest.swift
//  NorrisAppTests
//
//  Created by Lucas Moraes on 20/09/21.
//

import XCTest
@testable import NorrisApp

class NorrisBusinessTest: XCTestCase {

    var network: NorrisNetwork?
    var business: NorrisBusinessType?
    
    let mock = ResultMock()
    
    override func setUpWithError() throws {
        super.setUp()
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [NorrisURLProtocolMock.self]
        
        network = NorrisNetwork(sessionConfig: sessionConfiguration)
        business = NorrisBusiness(network: network)
        
    }

    override func tearDownWithError() throws {
        super.tearDown()
        
        business = nil
        network = nil

        NorrisURLProtocolMock.stubResponseData = nil
        NorrisURLProtocolMock.responseType = .none
    }
    
    
    func testGetCategoriesSuccess() {

        let expectation = self.expectation(description: "test success on getCategories from NorrisBusinessType's protocol")

        var categoriesRaw: Categories?
        var statusCode: Int?

        NorrisURLProtocolMock.stubResponseData = mock.categoriesDataSuccess
        NorrisURLProtocolMock.responseType = .success

        business?.getCategories { cat, sC in

            categoriesRaw = cat
            statusCode = sC

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)

        let categories = try? XCTUnwrap(categoriesRaw?.categories)

        XCTAssertNotNil(categories)
        XCTAssertEqual(categories?.count, 16)
        XCTAssertEqual(statusCode, 200)

    }
    
    func testGetCategoriesError() throws {

        let expectation = self.expectation(description: "test success on getCategories from NorrisBusinessType's protocol")

        var categories: Categories?
        var statusCode: Int?

        NorrisURLProtocolMock.responseType = .error

        business?.getCategories { cat, sC in

            categories = cat
            statusCode = sC

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
        
        XCTAssertNil(categories?.categories)
        XCTAssertEqual(statusCode, 400)

    }
}
