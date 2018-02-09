//
//  CacheType.swift
//  Moya
//
//  Created by Sanchew on 2018/2/5.
//

import Foundation


public protocol Cacheable {
    
    var cache: CacheType { get }
    var cacheKey: String { get }
    var flushType: CacheFlushType { get }
    
}

extension Cacheable {
    
    func save(_ response: Response) {
        switch self.cache {
        case .never:
            break
        case .disk(let seconed):
            try? storage.setObject(ResponseSink(response), forKey: cacheKey, expiry: .seconds(TimeInterval(seconed)))
        case .forever:
            try? storage.setObject(ResponseSink(response), forKey: cacheKey, expiry: .never)
        }
    }
    
    var flush: Bool {
        switch self.flushType {
        case .all:
            return true
        case .notInMemory:
            let cacheKey = self.cacheKey
            return !(storage.isOnMemory(forKey: cacheKey) && !((try? storage.entry(ofType: ResponseSink.self, forKey: cacheKey))?.expiry.isExpired ?? true))
        default:
            return false
        }
    }
    
}
