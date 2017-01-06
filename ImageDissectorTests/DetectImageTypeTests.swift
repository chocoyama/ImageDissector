//
//  DetectImageTypeTests.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import XCTest
@testable import ImageDissector

class DetectImageTypeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGIFImage() {
        let type = Type.detect(from: TestData.gif.data)
        XCTAssertEqual(type, Type.gif)
    }
    
    func testPNGImage() {
        let type = Type.detect(from: TestData.png.data)
        XCTAssertEqual(type, Type.png)
    }
    
    func testJPEGImage() {
        let type = Type.detect(from: TestData.jpeg.data)
        XCTAssertEqual(type, Type.jpeg)
    }
    
}
