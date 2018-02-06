//
//  CacheSink.swift
//  Moya
//
//  Created by Sanchew on 2018/2/5.
//

import UIKit

internal class ResponseSink: NSObject, NSCoding, Codable {
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

    private enum CodingKeys:String, CodingKey {
        case _statusCode, _data, _request, _response
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_statusCode, forKey: ._statusCode)
        try container.encode(_data, forKey: ._data)
        let _requestData = NSKeyedArchiver.archivedData(withRootObject: _request)
        try container.encode(_requestData, forKey: ._request)
        let _responseData = NSKeyedArchiver.archivedData(withRootObject: _response)
        try container.encode(_responseData, forKey: ._response)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _statusCode = try container.decode(Int.self, forKey: ._statusCode)
        _data = try container.decode(Data.self, forKey: ._data)
        let _requestData = try container.decode(Data.self, forKey: ._request)
        _request = NSKeyedUnarchiver.unarchiveObject(with: _requestData) as? URLRequest
        let _responseData = try container.decode(Data.self, forKey: ._response)
        _response = NSKeyedUnarchiver.unarchiveObject(with: _responseData) as? HTTPURLResponse
        super.init()
    }
    
    
}


