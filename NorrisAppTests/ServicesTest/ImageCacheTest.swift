//
//  ImageCacheTest.swift
//  NorrisAppTests
//
//  Created by Lucas Vinicius S. Corrêa de Moraes on 21/10/21.
//

import UIKit
import XCTest
@testable import NorrisApp

class ImageCacheTest: XCTestCase {
    
    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testImageCacheSuccess() {
        let exp = expectation(description: "test image cache success")
        
        let bundle = Bundle(for: self.classForCoder)
        let imagePath = bundle.path(forResource: "chuck-norris", ofType: "png")
        let imageUrl = URL(fileURLWithPath: imagePath!)
        
        var image: UIImage?
        
        ImageCache.shared.getImage(using: imageUrl) { img in
            image = img
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertNotNil(image)
    }
}
