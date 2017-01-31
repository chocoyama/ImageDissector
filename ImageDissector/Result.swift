//
//  Result.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/08.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

public enum Result {
    case success(CGSize, Type)
    case failure(Error, Type?)
    
    func getSize() -> CGSize? {
        switch self {
        case .success(let size, _): return size
        case .failure(_, _): return nil
        }
    }
    
    func getType() -> Type? {
        switch self {
        case .success(_, let type): return type
        case .failure(_, let type): return type
        }
    }
}
