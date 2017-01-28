//
//  Type.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

public enum Type {
    case gif
    case animationGif
    case png
    case jpeg
    case unsupported
    
    static func detect(from data: Data) -> Type {
        guard data.count >= 2 else { return .unsupported }
        
        var length = UInt16(0)
        let _ = data.copyBytes(to: .init(start: &length, count: 1), from: 0..<2)
        
        switch CFSwapInt16(length) {
        case 0xFFD8: return .jpeg
        case 0x8950: return .png
        case 0x4749:
            let result = GifParser.parse(data: data)
            switch result {
            case .gif: return .gif
            case .animationGif: return .animationGif
            case .something: return .unsupported
            }
        default: return .unsupported
        }
    }
    
    func extractSize(from data: Data) -> CGSize {
        switch self {
        case .gif, .animationGif:
            guard data.count >= 11 else { return CGSize.zero }
            
            var size = Size<UInt16>()
            let _ = data.copyBytes(to: .init(start: &size, count: 1), from: 6..<10)
            
            let width = Int(size.width)
            let height = Int(size.height)
            return CGSize.init(width: width, height: height)
            
        case .png:
            guard data.count >= 25 else { return CGSize.zero }
            
            var size = Size<UInt32>()
            let _ = data.copyBytes(to: .init(start: &size, count: 1), from: 16..<24)
            
            let width = Int(CFSwapInt32(size.width))
            let height = Int(CFSwapInt32(size.height))
            return CGSize.init(width: width, height: height)
            
        case .jpeg:
            guard data.count > 2 else { return CGSize.zero }
            
            let initialParameter = JPEGParser.Parameter.init(data: data, offset: 2, segment: .next)
            var result: JPEGParser.Result = .continue(initialParameter)
            while true {
                switch result {
                case .success(let size): return size
                case .continue(let parameter): result = JPEGParser.parse(with: parameter)
                }
            }
            
        case .unsupported:
            return CGSize.zero
        }
    }
}
