//
//  Stroage.swift
//  Moya
//
//  Created by Sanchew on 2018/2/6.
//

import Foundation
import Cache

let diskConfig = DiskConfig(name: "moyaCache")

internal let storage = try! Cache.Storage(diskConfig: diskConfig, memoryConfig: MemoryConfig(expiry: .never, countLimit: 50, totalCostLimit: 50))

public struct Storage {
    public static let `default` = storage
}

