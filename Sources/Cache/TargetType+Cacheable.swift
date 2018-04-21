//
//  TargetType+CacheKey.swift
//  Moya
//
//  Created by Sanchew on 2018/2/6.
//

import Foundation


extension Cacheable where Self: TargetType {
    
    public var _cacheKey: String {
        let endpoint = MoyaProvider.defaultEndpointMapping(for: self)
        let request = try! endpoint.urlRequest()
        let origin = NSKeyedArchiver.archivedData(withRootObject: request).base64EncodedString()
        //        origin.reduce(0, { $0 * 31 + $1.hashValue })
        //        print(" \(origin.hashValue) \(request) \(origin)")
        //        var key = request.url!.absoluteString
        //        if let data = request.httpBody {
        //            key = key + data.base64EncodedString()
        //        }
//        return "\(origin.reduce(0, { $0 &* 31 &+ UnicodeScalar("\($1)")!.value }))"
        return origin
    }
    
    public var cacheKey: String {
        return _cacheKey
    }
    
    public var flushType: CacheFlushType {
        return .never
    }
    
}

extension TargetType {
    
    internal var cacheable: Cacheable? {
        return self as? Cacheable
    }
    
}
