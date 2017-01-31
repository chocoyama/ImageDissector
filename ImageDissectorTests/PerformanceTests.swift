//
//  PerformanceTests.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import XCTest
import UIKit
@testable import ImageDissector

class PerformanceTests: XCTestCase {
    
    var dissector: ImageDissector?
    
    override func setUp() {
        super.setUp()
        dissector = ImageDissector()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
//    func testInitDataPerformance() {
//        self.measure {
//            let start = Date()
//            
//            let data = TestData.gif.data
//            let image = UIImage(data: data)
//            let _ = image?.size
//            
//            let span = start.timeIntervalSince(Date())
//            print("経過時間(Data) = \(span)")
//        }
//    }
//    
//    func testInitDataBigDataPerformance() {
//        self.measure {
//            let start = Date()
//            
//            let images = TestData.manyUrls.map{ try! Data.init(contentsOf: $0) }.map{ UIImage(data: $0) }
//            let _ = images.map{ $0?.size }
//            
//            let span = start.timeIntervalSince(Date())
//            print("経過時間(Data BIGDATA) = \(span)")
//        }
//    }
    
    func testDissectorPerformance() {
        let url = TestData.gif.url
        let start = Date()
        
        let expectation = self.expectation(description: "dissect")
        dissector?.dissectImage(with: url, completion: { (result) in
            defer {
                let span = start.timeIntervalSince(Date())
                print("経過時間(DISSECT) = \(span)")
                expectation.fulfill()
            }
            
            switch result {
            case .success(let size, let type):
                XCTAssertEqual(size, TestData.gif.size)
                XCTAssertEqual(type, Type.gif)
            case .failure(let error, let type):
                XCTAssertEqual(type, Type.gif)
                XCTFail(error.localizedDescription)
            }
            
        })
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testHeavyDataPerformance() {
        let url = TestData.heavyGif.url
        let start = Date()
        
        let expectation = self.expectation(description: "dissect")
        dissector?.dissectImage(with: url, completion: { (result) in
            defer {
                let span = start.timeIntervalSince(Date())
                print("経過時間(DISSECT) = \(span)")
                expectation.fulfill()
            }
            
            switch result {
            case .success(let size, let type):
                XCTAssertEqual(size, TestData.heavyGif.size)
                XCTAssertEqual(type, Type.gif)
            case .failure(let error, let type):
                XCTAssertEqual(type, Type.gif)
                XCTFail(error.localizedDescription)
            }
            
        })
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testDissectorBigDataPerformance() {
        let urls = TestData.manyUrls
        
        let start = Date()
        let expectation = self.expectation(description: "concurrent")
        
        dissector?.dissectImage(with: urls, completion: { (results) in
            defer {
                let span = start.timeIntervalSince(Date())
                print("経過時間(DISSECT BIGDATA) = \(span)")
                expectation.fulfill()
            }
            results.filter{ $0.value.getSize() == nil }.forEach{ print("Failure: \($0.key.absoluteString)") }
        })
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
