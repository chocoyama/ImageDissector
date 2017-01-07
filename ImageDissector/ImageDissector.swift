//
//  ImageDissector.swift
//  ImageDissector
//
//  Created by takyokoy on 2017/01/06.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

open class ImageDissector {
    
    public enum Result {
        case success(CGSize, Type)
        case failure(Error)
        
        func getSize() -> CGSize? {
            switch self {
            case .success(let size, _): return size
            case .failure(_): return nil
            }
        }
        
        func getType() -> Type? {
            switch self {
            case .success(_, let type): return type
            case .failure(_): return nil
            }
        }
    }
    
    fileprivate let session: URLSession
    fileprivate let delegate = ImageDissectSessionDelegate()
    
    public init() {
        session = URLSession.init(configuration: .default, delegate: self.delegate, delegateQueue: nil)
    }
}

extension ImageDissector {
    open func dissectImage(with url: URL, completion: @escaping (Result) -> Void) {
        let task = session.dataTask(with: url)
        let operation = DissectOperation(task: task)
        operation.completionBlock = { [weak self] in
            let result = operation.result ?? .failure(NSError.init(domain: "", code: 0, userInfo: nil))
            completion(result)
            self?.delegate.manager.removeOperation(at: url)
        }
        delegate.manager.addOperation(operation, with: url)
    }
    
    open func dissectImage(with urls: [URL], completion: @escaping ([URL: Result]) -> Void) {
        
        let group = DispatchGroup()
        var results = [URL: Result]()
        
        let uniqueUrls = NSOrderedSet.init(array: urls).array as! [URL]
        
        (0..<uniqueUrls.count).forEach{ _ in group.enter() }
        
        for url in uniqueUrls {
            DispatchQueue.main.async { [weak self] in
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
