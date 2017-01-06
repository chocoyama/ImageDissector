//
//  Operation.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

class DissectOperation: Operation {
    
    var result: ImageDissector.Result?
    
    private var mutableData = Data()
    private let dataTask: URLSessionDataTask
    
    init(task: URLSessionDataTask) {
        self.dataTask = task
    }
    
    override func start() {
        guard isCancelled == false else { return }
        dataTask.resume()
    }
    
    func appendData(data: Data) {
        if isCancelled == false {
            mutableData.append(data)
        }
        
        guard data.count >= 2 else { return }
        
        if isCancelled == false {
            parse()
        }
    }
    
    func terminateWith(error: Error) {
        complete(result: .failure(error))
    }
    
    private func parse() {
        let data = mutableData
        let type = Type.detect(from: data)
        
        if type != .unsupported {
            let size = type.extractSize(from: data)
            if size != CGSize.zero {
                complete(result: .success(size, type))
            }
        } else if data.count > 2 {
            complete(result: .failure(NSError.init(domain: "", code: 0, userInfo: nil)))
        }
    }
    
    private func complete(result: ImageDissector.Result) {
        self.result = result
        completionBlock?()
        super.cancel()
    }
}
