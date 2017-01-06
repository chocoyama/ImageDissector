//
//  SizeInjectionTests.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import XCTest
import UIKit
@testable import ImageDissector

class SizeInjectionTests: XCTestCase {
    
    var dissector: ImageDissector?
    
    override func setUp() {
        super.setUp()
        dissector = ImageDissector()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInjection() {
        let expectation = self.expectation(description: "injection")
        
        let injectionable = TestImageEntity.jpegEntity
        dissector?.dissectImage(with: injectionable, completion: { (resultInjectionable) in
            defer { expectation.fulfill() }
            
            XCTAssertEqual(injectionable.imageSize, TestData.jpeg.size)
            XCTAssertEqual(resultInjectionable.imageSize, TestData.jpeg.size)
        })
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testMultiInjection() {
        let expectation = self.expectation(description: "injection")
        
        let injectionables = [
            TestImageEntity.gifEntity,
            TestImageEntity.pngEntity,
            TestImageEntity.jpegEntity
        ]
        
        dissector?.dissectImage(with: injectionables, completion: { (resultInjectionables) in
            defer { expectation.fulfill() }
            
            XCTAssertEqual(injectionables[0].imageSize, TestData.gif.size)
            XCTAssertEqual(injectionables[1].imageSize, TestData.png.size)
            XCTAssertEqual(injectionables[2].imageSize, TestData.jpeg.size)
            XCTAssertEqual(resultInjectionables[0].imageSize, TestData.gif.size)
            XCTAssertEqual(resultInjectionables[1].imageSize, TestData.png.size)
            XCTAssertEqual(resultInjectionables[2].imageSize, TestData.jpeg.size)
        })
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}


class TestImageEntity: SizeInjectionable {
    var imageUrl: URL?
    var imageSize: CGSize?
    
    static var gifEntity: TestImageEntity {
        let entity = TestImageEntity()
        entity.imageUrl = TestData.gif.url
        return entity
    }
    
    static var pngEntity: TestImageEntity {
        let entity = TestImageEntity()
        entity.imageUrl = TestData.png.url
        return entity
    }
    
    static var jpegEntity: TestImageEntity {
        let entity = TestImageEntity()
        entity.imageUrl = TestData.jpeg.url
        return entity
    }
}
