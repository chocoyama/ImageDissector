//
//  Error.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/08.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

public enum ImageDissectorError: Error {
    case invalidUrl
    case cannotGetResult
    case brokenData
    case didCompleteWithError
}
