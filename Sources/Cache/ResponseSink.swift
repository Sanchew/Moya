//
//  CacheSink.swift
//  Moya
//
//  Created by Sanchew on 2018/2/5.
//

import UIKit
#if !COCOAPODS
    import Moya
#endif

internal class ResponseSink: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_statusCode, forKey: "statusCode")
        aCoder.encode(_data, forKey: "data")
        aCoder.encode(_request, forKey: "request")
        aCoder.encode(_response, forKey: "response")
    }

    required init?(coder aDecoder: NSCoder) {
        _statusCode = aDecoder.decodeInteger(forKey: "statusCode")
        _data = aDecoder.decodeObject(of: NSData.self, forKey: "data") as! Data
        _request = aDecoder.decodeObject(of: NSURLRequest.self, forKey: "request") as? URLRequest
        _response = aDecoder.decodeObject(of: HTTPURLResponse.self, forKey: "response")
    }
    
    /// The status code of the response.
    private let _statusCode: Int
    
    /// The response data.
    private let _data: Data
    
    /// The original URLRequest for the response.
    private let _request: URLRequest?
    
    /// The HTTPURLResponse object.
    private let _response: HTTPURLResponse?

    init(_ response: Response) {
        _statusCode = response.statusCode
        _data = response.data
        _request = response.request
        _response = response.response
    }

    var response: Response {
        return Response(statusCode: _statusCode, data: _data, request: _request, response: _response)
    }
    
}

