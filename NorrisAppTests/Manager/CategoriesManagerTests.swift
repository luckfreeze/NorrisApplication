//
//  CategoriesManagerTests.swift
//  NorrisAppTests
//
//  Created by Lucas Vinicius S. Corrêa de Moraes on 22/09/21.
//

import XCTest
@testable import NorrisApp

class CategoriesManagerTests: XCTestCase {
    
    var network: CategoriesNetworkType?
    var business: CategoriesBusinessType?
    var manager: CategoriesManagerType?
    
    let mock = ResultMock()
    
    var expectation: XCTestExpectation?
    var categories: [String]?
    var singleCategory: SingleCategory?
    
    let detail = "animal"
    
    override func setUpWithError() throws {
        super.setUp()
        
        network = CategoriesNetwork(sessionConfig: NorrisURLProtocolMock.sessionConfiguration())
        business = CategoriesBusiness(network: network)
        manager = CategoriesManager(delegate: self, business: business)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        business = nil
        network = nil
        singleCategory = nil

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
    
    func testGetCategorySuccess() {
        
        NorrisURLProtocolMock.stubResponseData = mock.categoryDataSuccess
        NorrisURLProtocolMock.responseType = .success
        
        expectation = expectation(description: "test success on getCategory from NorrisManagerDelegate's protocol")
        manager?.getCategory(detail)
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNotNil(singleCategory)
    }
    
    func testGetCategoryEmpty() {
        
        NorrisURLProtocolMock.stubResponseData = mock.emptyData
        NorrisURLProtocolMock.responseType = .empty
        
        expectation = expectation(description: "test empty case on getCategory from NorrisManagerDelegate's protocol")
        manager?.getCategory(detail)
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNil(singleCategory)
    }
    
    func testGetCategoryError() {
        
        NorrisURLProtocolMock.responseType = .error
        
        expectation = expectation(description: "test error on getCategory from NorrisManagerDelegate's protocol")
        manager?.getCategory(detail)
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNil(singleCategory)
    }
   
}

extension CategoriesManagerTests: CategoriesManagerDelegate {
    func handleSuccess(type: CategoriesSuccessType) {
        switch type {
        case .successOnCategories(let cat):
            
            self.categories = cat
            expectation?.fulfill()
            
        case .empty:
            expectation?.fulfill()
            
        case .successOnCategory(let singleCat):
            self.singleCategory = singleCat
            expectation?.fulfill()
        default:
            break
        }
    }
    
    func handleError(type: CategoriesErrorType) {
        switch type {
        case .error:
            expectation?.fulfill()
            
        }
    }
}
