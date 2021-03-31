//
//  Router.swift
//  NaukriIndia
//
//  Created by Himanshu Gupta on 01/08/18.
//  Copyright © 2018 Info Edge India Ltd. All rights reserved.
//

import Foundation
public typealias NetworkRouterCompletion = (_ response: APIRESPONSE)->()
public let queryDataKey = "queryDataKey"
public let postDataKey = "postDataKey"
public let multipartDataKey = "multipartDataKey"

enum mimeTypeEnum : String {
    case pngImage = "image/png"
    case jpegImage = "image/jpg"
    case videoFileMp4 = "video/mp4"
    case documentType = "application/octet-stream"

}
struct mediaContent {
    var mimeType: mimeTypeEnum?
    var data: Data?
    var fileName: String?
}
protocol NetworkRouter: class {
    associatedtype EndPoint: ApiEndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func multipartRequest(_ route: EndPoint, completion: @escaping NetworkRouterCompletion, progressHandler: @escaping ProgressHandler)
    func cancel()
}

class Router<EndPoint: ApiEndPointType>: NetworkRouter {
    var task: URLSessionTask?
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        
        let session = URLSession(configuration: .default)
        session.configuration.timeoutIntervalForRequest = 20.0
        session.configuration.httpCookieStorage = nil
        do {
            if(route.showLoader == true){
                NIUIHelper.sharedInstance.showLoader()
            }
            let request = try self.buildRequest(from: route)
            let _ = NetworkLogger.log(request: request)
            
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                ResponseParser.responseParser.parseAPIResponse(data: data, response: response, requestEndPoint: route, error: error, request: request) { (apiRes) in
                    NIUIHelper.sharedInstance.hideLoader()
                    let _ = NetworkLogger.log(response: apiRes)
                    completion(apiRes)
                }
            })
        }catch {
            print(error)
        }
        self.task?.resume()
    }
    
    func multipartRequest(_ route: EndPoint, completion: @escaping NetworkRouterCompletion, progressHandler: @escaping ProgressHandler) {
        
        let fileUploadObserver = FileUploaderTaskObserver()
        let session = URLSession(configuration: .default, delegate:fileUploadObserver  as URLSessionTaskDelegate, delegateQueue: nil)
        
        session.configuration.timeoutIntervalForRequest = 20.0
        session.configuration.httpCookieStorage = nil
        do {
            if(route.showLoader == true){
                NIUIHelper.sharedInstance.showLoader()
            }
            let request = try self.buildRequest(from: route)
            let _ = NetworkLogger.log(request: request)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                ResponseParser.responseParser.parseAPIResponse(data: data, response: response, requestEndPoint: route, error: error, request: request) { (apiRes) in
                    NIUIHelper.sharedInstance.hideLoader()
                    let _ = NetworkLogger.log(response: apiRes)
                    completion(apiRes)
                }
            })
        }catch {
            print(error)
        }
        if let taskId = self.task?.taskIdentifier{
            fileUploadObserver.progressHandlersByTaskID[taskId] = progressHandler
        }
        self.task?.resume()
    }
    
    func downloadTask(url: String,completionHandler: @escaping DownloadCompletionHandler, progressHandler: @escaping ProgressHandler) {
            let fileUploadObserver = FileUploaderTaskObserver()
            let session = URLSession(configuration: .default, delegate:fileUploadObserver, delegateQueue: nil)
            
            session.configuration.timeoutIntervalForRequest = 20.0
            session.configuration.httpCookieStorage = nil
            
                
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
        
            task = session.downloadTask(with: request)
            if let taskId = self.task?.taskIdentifier{
                fileUploadObserver.progressHandlersByTaskID[taskId] = progressHandler
                fileUploadObserver.completionHandler[taskId] = completionHandler
            }
            self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                break
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                break
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                break
                
            case .download(let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                break
                
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}

