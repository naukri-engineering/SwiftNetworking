//
//  ResponseModel.swift
//  NaukriIndia
//
//  Created by Himanshu Gupta on 03/08/18.
//  Copyright © 2018 Info Edge India Ltd. All rights reserved.
//

import Foundation
public struct APIRESPONSE {
    var isErrorHandled : Bool = false
    var errorMessagesDueToUnknownConditions : [String] = [String]()
    var response : URLResponse? = nil
    var request : URLRequest? = nil
    var data: Data? = nil
    var isSuccess: Bool = false
    var requestEndpoint : ApiEndPointType? = nil
    var isErrorWillBeHandledByVC: Bool = false
    var responseErrorMessage : ResponseErrorMessage?
    
    
    var responseHTTP: HTTPURLResponse? {
        return response as? HTTPURLResponse
    }
    func getHeaderField(key: String) -> String? {
        if let httpResponse = self.response as? HTTPURLResponse {
            let keyValues = httpResponse.allHeaderFields.map { (String(describing: $0.key).lowercased(), String(describing: $0.value)) }
            if let headerValue = keyValues.filter({ $0.0 == key.lowercased() }).first {
                return headerValue.1
            }
            return nil
        }
        return nil
    }
    var responseHeaders: [AnyHashable: Any]? {
        if let response = responseHTTP {
            return response.allHeaderFields
        } else {
            return nil
        }
    }
    var dataDictionary: Any? {
        if let responseData = data {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                return jsonData
            } catch {
                return nil
            }
        }
        return nil
    }
    init(data: Data?, error: Error?, response: URLResponse?, requestEndPoint : ApiEndPointType?, request: URLRequest?) {
        self.data = data
        self.response = response
        self.requestEndpoint = requestEndPoint
        self.request = request

        if let response = self.responseHTTP{
            let result = ResponseHandler.getApiStatus(response)
            switch result.0 {
            case .success:
                self.isSuccess =  true
            case .failure:
                self.isSuccess =  false
            }
            self.responseErrorMessage = ResponseErrorMessage(messages: nil, statusCode: result.statusCode, error:error)
        }
    }

}
