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
        return origin
    }
    
}

extension TargetType {
    
    var cache: Cacheable? {
        return self as? Cacheable
    }
    
}
