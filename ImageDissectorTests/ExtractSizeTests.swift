//
//  ExtractSizeTests.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import XCTest
@testable import ImageDissector

class ExtractSizeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    private func createImageData(from urlString: String) -> Data {
        let url = URL.init(string: urlString)!
        return try! Data.init(contentsOf: url)
    }
    
    func testGIFImage() {
        let size = Type.gif.extractSize(from: TestData.gif.data)
        XCTAssertEqual(size, TestData.gif.size)
    }
    
    func testPNGImage() {
        let size = Type.png.extractSize(from: TestData.png.data)
        XCTAssertEqual(size, TestData.png.size)
    }
    
    func testJPEGImage() {
        let size = Type.jpeg.extractSize(from: TestData.jpeg.data)
        XCTAssertEqual(size, TestData.jpeg.size)
    }
    
}
