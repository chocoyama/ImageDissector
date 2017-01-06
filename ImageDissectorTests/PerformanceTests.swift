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
    
    func testInitDataPerformance() {
        self.measure {
            let start = Date()
            
            let data = TestData.gif.data
            let image = UIImage(data: data)
            let _ = image?.size
            
            let span = start.timeIntervalSince(Date())
            print("経過時間(Data) = \(span)")
        }
    }
    
    func testDissectorPerformance() {
        let url = TestData.gif.url
        
        let start = Date()
        
        let expectation = self.expectation(description: "dissect")
        dissector?.dissectImage(with: url, completion: { (result) in
            defer { expectation.fulfill() }
            
            switch result {
            case .success(let size, let type):
                XCTAssertEqual(size, TestData.gif.size)
                XCTAssertEqual(type, Type.gif)
                
                let span = start.timeIntervalSince(Date())
                print("経過時間(DESECT) = \(span)")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
        })
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
}
