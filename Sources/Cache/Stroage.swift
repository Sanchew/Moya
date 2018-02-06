//
//  Stroage.swift
//  Moya
//
//  Created by Sanchew on 2018/2/6.
//

import Foundation
import Cache

let diskConfig = DiskConfig(name: "moyaCache")

internal let storage = try! Storage(diskConfig: diskConfig, memoryConfig: MemoryConfig(expiry: .never, countLimit: 20, totalCostLimit: 20))

//private struct CacheSink {
//    var access: Int
//}
//
//class MemStorage {
//
//}

