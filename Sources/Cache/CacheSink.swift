//
//  CacheSink.swift
//  Moya
//
//  Created by Sanchew on 2018/2/5.
//

import UIKit

internal class CacheSink: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(expires, forKey: "expires")
        aCoder.encode(response, forKey: "response")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.expires = aDecoder.decodeDouble(forKey: "expires")
        self.response = aDecoder.decodeObject(forKey: "response") as! Response
    }
    
    
    var expires: Double
    var response: Response
    
    init(expires: Double, response: Response) {
        self.expires = expires
        self.response = response
    }

}
