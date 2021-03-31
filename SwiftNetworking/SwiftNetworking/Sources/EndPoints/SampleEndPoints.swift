//
//  CompanyBrandingEndPoints.swift
//  NaukriIndia
//
//  Created by Ritesh Verma on 28/08/20.
//  Copyright © 2020 Info Edge India Ltd. All rights reserved.
//

import Foundation

enum SampleEndPoints {
    case get
    case post(parameters :[String:Any])
    case put(parameters :[String:Any])
    case delete(parameters :[String:Any])
    case getWithQuery(parameters :[String:Any])
    case postWithQuery(parameters :[String:Any])
    case multipartUpload(parameters :[String:Any])
}

extension SampleEndPoints : ApiEndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: BaseUrlType.mockBaseUrl.rawValue) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var errorHandlingInVC: Bool{
        switch self {
        case .get:
            return false
        default:
            return false
        }
    }
    var path: String {
        switch self {
        case .get:
            return "/getCall"
        case .post(_):
            return "/postCall"
        case .put(_):
            return "/putCall"
        case .delete(_):
            return "/deleteCall"
        case .getWithQuery(_):
            return "/getWithQuery"
        case .postWithQuery(_):
            return "/postWithQuery"
        case .multipartUpload(_):
            return "/multipart"
        
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .get, .getWithQuery(_):
            return .get
        case .post(_), .postWithQuery(_):
            return .post
        case .put(_):
            return .put
        case .delete(_):
            return .delete
        case .multipartUpload(_):
            return .post
        }
    }
    var showLoader: Bool {
        switch self {
        default:
            return false
        }
    }
    
    var task: HTTPTask {
        switch self {
            case .get:
                return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
                
            case .post(let params):
                if let postData = params[postDataKey] as? [String: Any]{
                    return .requestParametersAndHeaders(bodyParameters: postData, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
                }else{
                    return .requestParametersAndHeaders(bodyParameters: params, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
                }
            case .put(let params):
                if let postData = params[postDataKey] as? [String: Any]{
                    return .requestParametersAndHeaders(bodyParameters: postData, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
                }else{
                    return .requestParametersAndHeaders(bodyParameters: params, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
                }
            case .delete(let params):
                if let postData = params[postDataKey] as? [String: Any]{
                    return .requestParametersAndHeaders(bodyParameters: postData, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
                }else{
                    return .requestParametersAndHeaders(bodyParameters: params, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
                }
            case .getWithQuery(let params):
                if let queryData = params[queryDataKey] as? [String: Any]{
                    return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: queryData, additionHeaders: headers)
                }else{
                    return .requestParametersAndHeaders(bodyParameters: params, bodyEncoding: .urlEncoding, urlParameters: nil, additionHeaders: headers)
                }
            case .postWithQuery(let params):
                if let postData = params[postDataKey] as? [String: Any],let queryData = params[queryDataKey] as? [String: Any]{
                    return .requestParametersAndHeaders(bodyParameters: postData, bodyEncoding: .urlAndJsonEncoding, urlParameters: queryData, additionHeaders: headers)
                }else{
                    return .requestParametersAndHeaders(bodyParameters: params, bodyEncoding: .urlAndJsonEncoding, urlParameters: nil, additionHeaders: headers)
                }
        case .multipartUpload(let params):
            if let _ = params[multipartDataKey] as? mediaContent{
                return .requestParametersAndHeaders(bodyParameters: params, bodyEncoding: .multipartEncoding, urlParameters: nil, additionHeaders: headers)
            }else{
                return .requestParametersAndHeaders(bodyParameters: params, bodyEncoding: .multipartEncoding, urlParameters: nil, additionHeaders: headers)
            }
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
            case .get:
                return self.defaultHeaders
            case .post(_):
                return self.defaultHeaders
            case .put(_):
                var headers = self.defaultHeaders
                headers["X-HTTP-Method-Override"] = "PUT"
                return headers
            case .delete(_):
                var headers = self.defaultHeaders
                headers["X-HTTP-Method-Override"] = "DELETE"
                return headers
                
            default:
                return self.defaultHeaders
        }
    }
}
