//
//  TargetType+CacheKey.swift
//  Moya
//
//  Created by Sanchew on 2018/2/6.
//

import Foundation


extension TargetType {

    var cacheKey: String {
        return self.baseURL.appendingPathComponent(self.path).absoluteString
    }
    
}
