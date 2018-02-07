//
//  Stroage.swift
//  Alamofire
//
//  Created by Sanchew on 2018/2/7.
//

import Foundation
import AwesomeCache


internal let storage: Cache<ResponseSink> = try! Cache<ResponseSink>(name: "moyaCache")
