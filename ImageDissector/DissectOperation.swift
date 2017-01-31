//
//  Operation.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

class DissectOperation: Operation {
    
    var result: Result?
    var detectType: Type?
    
    private var stackData = Data()
    private let dataTask: URLSessionDataTask
    
    init(task: URLSessionDataTask) {
        self.dataTask = task
    }
    
    override func start() {
        guard isCancelled == false else { return }
        dataTask.resume()
    }
    
    func append(data: Data) {
        guard isCancelled == false else { return }
        stackData.append(data)
        
        guard data.count >= 2 else { return }
        parse()
    }
    
    func terminateWith(error: Error) {
        complete(result: .failure(error, detectType))
    }
    
    func reset() {
        stackData = Data()
    }
    
    private func parse() {
        let data = stackData
        let type = Type.detect(from: data)
        self.detectType = type
        
        if type != .unsupported {
            let size = type.extractSize(from: data)
            complete(result: .success(size, type))
        } else if data.count > 2 {
            complete(result: .failure(ImageDissectorError.brokenData, type))
        }
    }
    
    private func complete(result: Result) {
        self.result = result
        completionBlock?()
        super.cancel()
    }
}
