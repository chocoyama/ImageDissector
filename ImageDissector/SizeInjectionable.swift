//
//  SizeInjectionable.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import UIKit

public protocol SizeInjectionable: class {
    var imageUrl: URL? { get set }
    
    var imageSize: CGSize? { get set }
    var imageType: Type? { get set }
}
