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
        complete(result: .failure(error))
    }
    
    func reset() {
        stackData = Data()
    }
    
    private func parse() {
        let data = stackData
        let type = Type.detect(from: data)
        
        if type != .unsupported {
            let size = type.extractSize(from: data)
            complete(result: .success(size, type))
        } else if data.count > 2 {
            let error = NSError.init(domain: "", code: 0, userInfo: nil)
            complete(result: .failure(error))
        }
    }
    
    private func complete(result: ImageDissector.Result) {
        self.result = result
        completionBlock?()
        super.cancel()
    }
}
