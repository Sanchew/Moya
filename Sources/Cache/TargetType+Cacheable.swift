//
//  TargetType+Cacheable.swift
//  Moya
//
//  Created by Sanchew on 2018/2/7.
//

import Foundation


extension Cacheable where Self: TargetType {
    
    public var cacheKey: String {
        let endpoint = MoyaProvider.defaultEndpointMapping(for: self)
        let request = try! endpoint.urlRequest()
        let origin = NSKeyedArchiver.archivedData(withRootObject: request).base64EncodedString()
//        origin.reduce(0, { $0 * 31 + $1.hashValue })
//        print(" \(origin.hashValue) \(request) \(origin)")
//        var key = request.url!.absoluteString
//        if let data = request.httpBody {
//            key = key + data.base64EncodedString()
//        }
        return "\(origin.reduce(0, { $0 &* 31 &+ UnicodeScalar("\($1)")!.value }))"
    }
    
}

extension TargetType {
    
    var cacheable: Cacheable? {
        return self as? Cacheable
    }
    
}
