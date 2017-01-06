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
    
    private let session: URLSession
    private let delegate = ImageDissectSessionDelegate()
    
    init() {
        session = URLSession.init(configuration: .default, delegate: self.delegate, delegateQueue: nil)
    }
    
    open func dissectImage(with url: URL, completion: @escaping (Result) -> Void) {
        let task = session.dataTask(with: url)
        let operation = DissectOperation(task: task)
        operation.completionBlock = { [weak self] in
            let result = operation.result ?? .failure(NSError.init(domain: "", code: 0, userInfo: nil))
            completion(result)
            self?.delegate.removeOperation(at: url)
        }
        delegate.addOperation(operation, with: url)
    }
    
    open func dissectImage(with urls: [URL], completion: @escaping ([URL: Result]) -> Void) {
        let group = DispatchGroup()
        
        var results = [URL: Result]()
        
        for url in urls {
            group.enter()
            DispatchQueue.main.async { [weak self] in
                self?.dissectImage(with: url, completion: { (result) in
                    results[url] = result
                    group.leave()
                })
            }
        }
        
        group.notify(queue: .main) {
            completion(results)
        }
    }
    
    open func dissectImage(with target: SizeInjectionable, completion: @escaping (SizeInjectionable) -> Void) {
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
    
    open func dissectImage(with targets: [SizeInjectionable], completion: @escaping ([SizeInjectionable]) -> Void) {
        let urls = targets.flatMap{ $0.imageUrl }
        dissectImage(with: urls) { (results) in
            for (url, result) in results {
                switch result {
                case .success(let size, _):
                    targets.filter{ $0.imageUrl == url }.forEach{ $0.imageSize = size }
                case .failure(_):
                    break
                }
            }
            completion(targets)
        }
    }
    
}
