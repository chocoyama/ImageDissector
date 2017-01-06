//
//  ImageDissectorTests.swift
//  ImageDissectorTests
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import XCTest
@testable import ImageDissector

class ImageDissectorTests: XCTestCase {
    
    var dissector: ImageDissector?
    
    override func setUp() {
        super.setUp()
        dissector = ImageDissector()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDissectGIFImage() {
        let url = TestData.gif.url
        
        let expectation = self.expectation(description: "dissect")
        dissector?.dissectImage(with: url, completion: { (result) in
            defer { expectation.fulfill() }
            
            switch result {
            case .success(let size, let type):
                XCTAssertEqual(size, TestData.gif.size)
                XCTAssertEqual(type, Type.gif)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testDissectPNGImage() {
        let url = TestData.png.url
        
        let expectation = self.expectation(description: "dissect")
        dissector?.dissectImage(with: url, completion: { (result) in
            defer { expectation.fulfill() }
            
            switch result {
            case .success(let size, let type):
                XCTAssertEqual(size, TestData.png.size)
                XCTAssertEqual(type, Type.png)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testDissectJPEGImage() {
        let url = TestData.jpeg.url
        
        let expectation = self.expectation(description: "dissect")
        dissector?.dissectImage(with: url, completion: { (result) in
            defer { expectation.fulfill() }
            
            switch result {
            case .success(let size, let type):
                XCTAssertEqual(size, TestData.jpeg.size)
                XCTAssertEqual(type, Type.jpeg)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testConcurrentDissection() {
        let urls = [
            TestData.gif.url,
            TestData.png.url,
            TestData.jpeg.url
        ]
        
        let expectation = self.expectation(description: "concurrent")
        dissector?.dissectImages(with: urls, completion: { (results) in
            defer { expectation.fulfill() }
            
            let gifResult = results[TestData.gif.url]!
            let pngResult = results[TestData.png.url]!
            let jpegResult = results[TestData.jpeg.url]!
            
            switch gifResult {
            case .success(let size, let type):
                XCTAssertEqual(size, TestData.gif.size)
                XCTAssertEqual(type, Type.gif)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            switch pngResult {
            case .success(let size, let type):
                XCTAssertEqual(size, TestData.png.size)
                XCTAssertEqual(type, Type.png)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            switch jpegResult {
            case .success(let size, let type):
                XCTAssertEqual(size, TestData.jpeg.size)
                XCTAssertEqual(type, Type.jpeg)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
}
