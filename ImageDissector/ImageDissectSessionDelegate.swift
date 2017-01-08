//
//  ImageDissectSessionDelegate.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

internal class ImageDissectSessionDelegate: NSObject, URLSessionDataDelegate {
    
    let manager = ImageDissectOperationManager()
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let operation = manager.getOperation(by: dataTask)
        operation?.append(data: data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        let operation = manager.getOperation(by: task)
        operation?.terminateWith(error: error ?? ImageDissectorError.didCompleteWithError)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        let operation = manager.getOperation(by: task)
        operation?.reset()
        completionHandler(request)
    }
}

