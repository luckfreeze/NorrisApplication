//
//  NorrisManagerTests.swift
//  NorrisAppTests
//
//  Created by Lucas Vinicius S. Corrêa de Moraes on 22/09/21.
//

import XCTest
@testable import NorrisApp

class NorrisManagerTests: XCTestCase {
    
    var network: NorrisNetworkType?
    var business: NorrisBusinessType?
    var manager: NorrisManagerType?
    
    let mock = ResultMock()
    
    var expectation: XCTestExpectation?
    var categories: [String]?
    
    override func setUpWithError() throws {
        super.setUp()
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [NorrisURLProtocolMock.self]
        
        network = NorrisNetwork(sessionConfig: sessionConfiguration)
        business = NorrisBusiness(network: network)
        manager = NorrisManager(delegate: self, business: business)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        business = nil
        network = nil

        NorrisURLProtocolMock.stubResponseData = nil
        NorrisURLProtocolMock.responseType = .none
        
    }
    
    
    func testGetCategoriesSuccess() {
        
        NorrisURLProtocolMock.stubResponseData = mock.categoriesDataSuccess
        NorrisURLProtocolMock.responseType = .success
        
        expectation = expectation(description: "test success on getCategories from NorrisManagerDelegate's protocol")
        manager?.getCategories()
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNotNil(categories)
    }
    
    func testGetCategoriesEmpty() {
        
        NorrisURLProtocolMock.stubResponseData = mock.emptyData
        NorrisURLProtocolMock.responseType = .empty
        
        expectation = expectation(description: "test success on getCategories from NorrisManagerDelegate's protocol")
        manager?.getCategories()
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNil(categories)
    }
    
    func testGetCategoriesError() {
        
        NorrisURLProtocolMock.responseType = .error
        
        expectation = expectation(description: "test success on getCategories from NorrisManagerDelegate's protocol")
        manager?.getCategories()
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNil(categories)
    }
   
}

extension NorrisManagerTests: NorrisManagerDelegate {
    func handleSuccess(type: NorrisSuccessType) {
        switch type {
        case .successOnCategories(let cat):
            
            self.categories = cat
            expectation?.fulfill()
            
        case .empty:
            expectation?.fulfill()
            
        default:
            break
        }
    }
    
    func handleError(type: NorrisErrorType) {
        switch type {
        case .error, .errorOnDecoded:
            expectation?.fulfill()
            
        }
    }
}
