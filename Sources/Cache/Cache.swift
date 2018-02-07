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
    case memory
    case disk(seconds: Int)
    case forever
}
