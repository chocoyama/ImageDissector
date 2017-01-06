//
//  TestData.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import UIKit

enum TestData {
    case gif
    case png
    case jpeg
    
    var urlString: String {
        switch self {
        case .gif: return "http://www.city.yokohama.lg.jp/kankyo/nousan/brand/hamanaranking/tamanegi.gif"
        case .png: return "http://umaihirado.jp/wp-content/uploads/ji_tamanegi.png"
        case .jpeg: return "http://livingpedia.net/wp-content/uploads/2015/06/lgf01a201312280900.jpg"
        }
    }
    
    var url: URL {
        return URL.init(string: urlString)!
    }
    
    var data: Data {
        return createImageData(from: urlString)
    }
    
    var size: CGSize {
        switch self {
        case .gif: return CGSize.init(width: 308, height: 309)
        case .png: return CGSize.init(width: 263, height: 205)
        case .jpeg: return CGSize.init(width: 1024, height: 1024)
        }
    }
    
    private func createImageData(from urlString: String) -> Data {
        return try! Data.init(contentsOf: url)
    }
}

