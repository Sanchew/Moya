//
//  TargetType+CacheKey.swift
//  Moya
//
//  Created by Sanchew on 2018/2/6.
//

import Foundation


extension TargetType {

    var cacheKey: String {
        let endpoint = MoyaProvider.defaultEndpointMapping(for: self)
        let request = try! endpoint.urlRequest()
        let origin = NSKeyedArchiver.archivedData(withRootObject: request).base64EncodedString()
        return "\(origin.hashValue)"
    }
    
}
