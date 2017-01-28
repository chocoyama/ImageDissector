//
//  GifParserTests.swift
//  ImageDissector
//
//  Created by Takuya Yokoyama on 2017/01/28.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import XCTest
@testable import ImageDissector

class GifParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParse() {
        let gifUrl = URL(string: "http://www.hyuki.com/icon/500x500.gif")!
        let gifData = try! Data(contentsOf: gifUrl)
        let gifType = Type.detect(from: gifData)
        XCTAssertEqual(gifType, Type.gif)
        
        let animationGifUrl = URL(string: "https://img.gifmagazine.net/gifmagazine/images/541495/original.gif?1441690957")!
        let animationGifData = try! Data(contentsOf: animationGifUrl)
        let animationGifType = Type.detect(from: animationGifData)
        XCTAssertEqual(animationGifType, Type.animationGif)
    }
    
}
