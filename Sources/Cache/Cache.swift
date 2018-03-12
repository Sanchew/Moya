//
//  Cache.swift
//  Moya
//
//  Created by Sanchew on 2018/2/5.
//

import Foundation

public enum CacheType {
    public static let `default`: CacheType = .never
    case never
    case disk(seconds: Int)
    case forever
}

public enum CacheFlushType {
    // never fluah
    case never
    // flush by not in memory
    case notInMemory
    // 
    case all
}

extension CacheType: Equatable {
    public static func ==(lhs: CacheType, rhs: CacheType) -> Bool {
        switch (lhs, rhs) {
        case (.never, .never):
            return true
        case (.forever, .forever):
            return true
        default:
            return false
        }
    }
    
    
}
