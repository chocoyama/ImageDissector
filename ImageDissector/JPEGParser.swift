//
//  Parser.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

struct JPEGParser {
    enum Result {
        case success(CGSize)
        case `continue`(Parameter)
    }
    
    struct Parameter {
        let data: Data
        let offset: Int
        let segment: HeaderSegment
        
        enum HeaderSegment {
            case next
            case sof
            case skip
            case parse
            case eoi
        }
    }
    
    static func parse(with parameter: Parameter) -> Result {
        let data = parameter.data
        let offset = parameter.offset
        let segment = parameter.segment
        
        if parameter.segment == .eoi
            || (data.count <= offset + 1)
            || (data.count <= offset + 2 && segment == .skip)
            || (data.count <= offset + 7 && segment == .parse) {
            return .success(CGSize.zero)
        }
        
        switch parameter.segment {
        case .next:
            let nextOffset = offset + 1
            var byte = UInt16(0)
            let _ = data.copyBytes(
                to: .init(start: &byte, count: 1),
                from: nextOffset..<(nextOffset + 1)
            )
            
            let param: Parameter
            if byte == 0xFF {
                param = .init(data: data, offset: parameter.offset + 1, segment: .sof)
            } else {
                param = .init(data: data, offset: parameter.offset + 1, segment: .next)
            }
            return .continue(param)
            
        case .sof:
            let nextOffset = offset + 1
            var byte = UInt16(0)
            let _ = data.copyBytes(
                to: .init(start: &byte, count: 1),
                from: nextOffset..<(nextOffset + 1)
            )
            
            let param: Parameter
            switch byte {
            case 0xE0...0xEF:
                param = .init(data: data, offset: nextOffset, segment: .skip)
            case 0xC0...0xC3, 0xC5...0xC7, 0xC9...0xCB, 0xCD...0xCF:
                param = .init(data: data, offset: nextOffset, segment: .parse)
            case 0xFF:
                param = .init(data: data, offset: nextOffset, segment: .sof)
            case 0xD9:
                param = .init(data: data, offset: nextOffset, segment: .eoi)
            default:
                param = .init(data: data, offset: nextOffset, segment: .skip)
            }
            return .continue(param)
            
        case .skip:
            var length = UInt16(0)
            let _ = data.copyBytes(
                to: .init(start: &length, count: 1),
                from: (offset + 1)..<(offset + 3)
            )
            
            let newOffset = offset + Int(CFSwapInt16(length)) - 1
            let param = Parameter.init(data: data, offset: newOffset, segment: .next)
            return .continue(param)
            
        case .parse:
            var size = Size<UInt16>()
            let _ = data.copyBytes(
                to: .init(start: &size, count: 1),
                from: (offset + 4)..<(offset + 8)
            )
            let width = Int(CFSwapInt16(size.width))
            let height = Int(CFSwapInt16(size.height))
            return .success(CGSize.init(width: width, height: height))
            
        default:
            return .success(CGSize.zero)
        }
    }
}
