//
//  ResponseParser.swift
//  NaukriIndia
//
//  Created by Himanshu Gupta on 31/07/18.
//  Copyright © 2018 Info Edge India Ltd. All rights reserved.
//

import Foundation

struct ResponseParser {
   
    static let responseParser = ResponseParser()
    public func parseAPIResponse(data: Data?, response: URLResponse?,requestEndPoint: ApiEndPointType?, error: Error?,request: URLRequest? , completion: @escaping (_ apiresponse: APIRESPONSE)->()){
        var responseObject = APIRESPONSE(data: data, error: error, response: response, requestEndPoint: requestEndPoint, request: request)
        ResponseHandler().handleApiResponse(&responseObject)
        completion(responseObject)

    }
}
