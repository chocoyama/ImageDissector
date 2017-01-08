//
//  ImageDissector.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

open class ImageDissector {
    
    fileprivate let session: URLSession
    fileprivate let delegate = ImageDissectSessionDelegate()
    
    private let timeoutSec = 1.0
    
    public init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutSec
        session = URLSession.init(configuration: configuration, delegate: self.delegate, delegateQueue: nil)
    }
    
}

extension ImageDissector {
    open func dissectImage(with url: URL, completion: @escaping (Result) -> Void) {
        guard url.absoluteString.characters.count > 0 else {
            completion(.failure(ImageDissectorError.invalidUrl))
            return
        }
        
        let task = session.dataTask(with: url)
        let operation = DissectOperation(task: task)
        operation.completionBlock = { [weak self] in
            let result = operation.result ?? .failure(ImageDissectorError.cannotGetResult)
            completion(result)
            self?.delegate.manager.removeOperation(at: url)
        }
        delegate.manager.addOperation(operation, with: url)
    }
    
    open func dissectImage(with urls: [URL], completion: @escaping ([URL: Result]) -> Void) {
        
        let group = DispatchGroup()
        var results = [URL: Result]()
        
        let uniqueUrls = NSOrderedSet.init(array: urls).array as! [URL]
        for url in uniqueUrls {
            group.enter()
            DispatchQueue.main.async(group: group) { [weak self] in
                self?.dissectImage(with: url, completion: { (result) in
                    guard let _  = self else { return }
                    results[url] = result
                    group.leave()
                })
            }
        }
        
        group.notify(queue: .main) { completion(results) }
    }
}

extension ImageDissector {
    open func dissectImage<T: SizeInjectionable>(with target: T, completion: @escaping (T) -> Void) {
        guard let imageUrl = target.imageUrl else {
            completion(target)
            return
        }
        
        dissectImage(with: imageUrl) { (result) in
            switch result {
            case .success(let size, _): target.imageSize = size
            case .failure(_): break
            }
            completion(target)
        }
    }
    
    open func dissectImage<T: SizeInjectionable>(with targets: [T], completion: @escaping ([T]) -> Void) {
        let urls = targets.flatMap{ $0.imageUrl }
        dissectImage(with: urls) { (results) in
            for (url, result) in results {
                switch result {
                case .success(let size, _):
                    targets
                        .filter{ $0.imageUrl == url }
                        .forEach{ $0.imageSize = size }
                    
                case .failure(_):
                    break
                }
            }
            completion(targets)
        }
    }
    
}
