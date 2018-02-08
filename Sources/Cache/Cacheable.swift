//
//  CacheType.swift
//  Moya
//
//  Created by Sanchew on 2018/2/5.
//

import Foundation
import Moya

public protocol Cacheable {
    
    var cache: CacheType { get }
    var cacheKey: String { get }
    
}


extension Cacheable {
    
    func save(_ response: Response) {
        switch self.cache {
        case .never:
            break
        case .memory:
            //                        storage.setObject(ResponseSink(response), forKey: key, expires: .seconds(600))
            break
        case .disk(let seconed):
            storage.setObject(ResponseSink(response), forKey: cacheKey, expires: .seconds(TimeInterval(seconed)))
        case .forever:
            storage.setObject(ResponseSink(response), forKey: cacheKey, expires: .never)
        }
    }
    
}
