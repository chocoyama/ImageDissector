//
//  ImageDissectOperationManager.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

internal class ImageDissectOperationManager {
    
    private let queue = OperationQueue()
    private var operations = [String: DissectOperation]()
    
    deinit {
        queue.cancelAllOperations()
    }
    
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
        if let originalUrl = task.originalRequest?.url,
            let operation = getOperation(at: originalUrl) {
            return operation
        } else {
            return nil
        }
    }
}
