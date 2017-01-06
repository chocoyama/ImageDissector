//
//  ImageDissectSessionDelegate.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

internal class ImageDissectSessionDelegate: NSObject, URLSessionDataDelegate {
    private let queue = OperationQueue()
    private var operations = [String: DissectOperation]()
    
    func addOperation(_ operation: DissectOperation, with url: URL) {
        operations[url.absoluteString] = operation
        queue.addOperation(operation)
    }
    
    func removeOperation(at url: URL) {
        operations[url.absoluteString] = nil
    }
    
    func getOperation(at url: URL) -> DissectOperation? {
        return operations[url.absoluteString]
    }
    
    func getOperation(by task: URLSessionTask) -> DissectOperation? {
        if let requestUrl = task.currentRequest?.url,
            let operation = getOperation(at: requestUrl) {
            return operation
        } else {
            return nil
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let operation = getOperation(by: dataTask)
        operation?.appendData(data: data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        let operation = getOperation(by: task)
        operation?.terminateWith(error: error ?? NSError.init(domain: "", code: 0, userInfo: nil))
    }
}
