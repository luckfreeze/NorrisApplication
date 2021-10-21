//
//  PrettyJsonTest.swift
//  NorrisAppTests
//
//  Created by Lucas Vinicius S. Corrêa de Moraes on 10/10/21.
//

import XCTest

class PrettyJsonTest: XCTestCase {

    func testPrettyJsonSuccess() {
        let data = """
        {"name":"NorrisApp", "version": "1.0.0"}
        """.data(using: .utf8)!
        
        let prettyJsonOptonal = data.prettyJson
        
        let prettyJ = try? XCTUnwrap(prettyJsonOptonal)
        
        XCTAssertNotNil(prettyJ)
    }
    
    func testPrettyJsonError() {
        let data = """
        {"name":  "version": "1.0.0"}
        """.data(using: .utf8)!
        
        let prettyJsonOptonal = data.prettyJson
        
        XCTAssertNil(prettyJsonOptonal)
    }

}
