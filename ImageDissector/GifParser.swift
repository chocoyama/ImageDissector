//
//  GifParser.swift
//  ImageDissector
//
//  Created by Takuya Yokoyama on 2017/01/28.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

struct GifParser {
    
    enum Result {
        case gif
        case animationGif
        case something
    }
    
    static func parse(data: Data) -> Result {
        guard data.count > 6 else { return .something }
        
        var byte = UInt16(0)
        // Gifかどうかの判定
        let _ = data.copyBytes(to: .init(start: &byte, count: 1), from: 4..<5)
        guard byte == 0x39 else { return .something }
        
        var offset = 6
        
        // 拡張ブロックまで送る
        while data.count > offset + 1 {
            let _ = data.copyBytes(to: .init(start: &byte, count: 1), from: offset..<(offset + 1))
            offset += 1
            if byte == 0x21 {
                break
            }
        }
        
        while data.count > offset + 2 {
            let _ = data.copyBytes(to: .init(start: &byte, count: 1), from: offset..<(offset + 2))
            offset += 2
            if byte == 0xf904 {
                return .animationGif
            }
        }
        
        return .gif
    }
}
