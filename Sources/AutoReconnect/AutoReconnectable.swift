//
//  AutoReconnectable.swift
//  Moya
//
//  Created by Sanchew on 2018/4/24.
//

import Foundation

public protocol AutoReconnectable {
    
    var autoReconnect: Bool { get }
    var interval: Int { get }
    
}
