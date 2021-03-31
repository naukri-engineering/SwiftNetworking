//
//  ResponseHandler.swift
//  NaukriIndia
//
//  Created by Himanshu Gupta on 03/08/18.
//  Copyright © 2018 Info Edge India Ltd. All rights reserved.
//

import Foundation
enum Result<String>{
    case success
    case failure
}

class ResponseHandler : NSObject {
    
     func handleApiResponse( _ response : inout APIRESPONSE){
        
        if let apiError = response.responseErrorMessage?.error {
            //handle the error coming from due to network issue
            if(apiError.code == NSURLErrorNotConnectedToInternet){
                response.errorMessagesDueToUnknownConditions = [NetworkResponse.NoNetworkConnection.rawValue]
                response.isErrorHandled = true
                DispatchQueue.main.async {
                    NIUIHelper.sharedInstance.showBannerMessage(NetworkResponse.NoNetworkConnection.rawValue, isSuccess: .error)
                }
            }
            else if (apiError.code == NSURLErrorCannotFindHost) {
                response.errorMessagesDueToUnknownConditions = [NetworkResponse.connectionNotestablished.rawValue]
                response.isErrorHandled = true
                DispatchQueue.main.async {
                    NIUIHelper.sharedInstance.showBannerMessage(NetworkResponse.connectionNotestablished.rawValue, isSuccess: .error)
                }
            }
            
            else if(apiError.code == NSURLErrorSecureConnectionFailed || apiError.code == NSURLErrorSecureConnectionFailed || apiError.code == NSURLErrorServerCertificateHasBadDate || apiError.code == NSURLErrorServerCertificateUntrusted || apiError.code == NSURLErrorServerCertificateHasUnknownRoot || apiError.code == NSURLErrorServerCertificateNotYetValid || apiError.code == errSSLXCertChainInvalid || apiError.code == errSSLUnknownRootCert || apiError.code == errSSLNoRootCert || apiError.code == errSSLCertExpired || apiError.code == errSSLCertNotYetValid || apiError.code == errSSLHostNameMismatch){
                response.errorMessagesDueToUnknownConditions = [NetworkResponse.sslErrorMessage.rawValue]
                response.isErrorHandled = true
                DispatchQueue.main.async {
                    NIUIHelper.sharedInstance.showBannerMessage(NetworkResponse.sslErrorMessage.rawValue, isSuccess: .error)
                }
            }
            else if(apiError.code == NSURLErrorTimedOut){
                response.errorMessagesDueToUnknownConditions = [NetworkResponse.RequestTimedOut.rawValue]
                response.isErrorHandled = true
                DispatchQueue.main.async {
                    NIUIHelper.sharedInstance.showBannerMessage(NetworkResponse.RequestTimedOut.rawValue, isSuccess: .error)
                }
            }
            else{
                let str = apiError.localizedDescription
                if str.isEmpty == false{
                    response.errorMessagesDueToUnknownConditions = [str]
                }else{
                    response.errorMessagesDueToUnknownConditions = [NetworkResponse.someErrorOccuredString.rawValue]
                }
            }
        }else{
            //handle the error coming from api server not due to network issue or something
            //parse the validation error data in NIErrorMessage
            if let errorMessage = response.responseErrorMessage{
                if let value = response.requestEndpoint?.errorHandlingInVC, value == true{
                    response.isErrorWillBeHandledByVC = true
                    return;
                }
                
                switch errorMessage.statusCode {
                case StatusCodeResult.badRequest.rawValue:
                    response.isErrorHandled = true
                    DispatchQueue.main.async {
                      NIUIHelper.sharedInstance.showBannerMessage(NetworkResponse.badRequestMessage.rawValue, isSuccess: .error)
                    }
                    break
                case StatusCodeResult.unAuthorized.rawValue:
                    
                    response.isErrorHandled = true
                    DispatchQueue.main.async {
                      NIUIHelper.sharedInstance.showBannerMessage(NetworkResponse.unAuthorizedMessage.rawValue, isSuccess: .error)
                    }
                    break
                    
                case StatusCodeResult.notFound.rawValue:
                    response.isErrorHandled = true
                    DispatchQueue.main.async {
                      NIUIHelper.sharedInstance.showBannerMessage(NetworkResponse.notFoundMessage.rawValue, isSuccess: .error)
                    }
                    break
                case StatusCodeResult.serverError.rawValue,StatusCodeResult.serverGatewayError.rawValue ,StatusCodeResult.serviceUnavailable.rawValue:
                    response.isErrorHandled = true
                    DispatchQueue.main.async {
                      NIUIHelper.sharedInstance.showBannerMessage(NetworkResponse.serverErrorMessage.rawValue, isSuccess: .error)
                    }
                    break
                case StatusCodeResult.unknown.rawValue:
                    
                    response.isErrorHandled = true
                    DispatchQueue.main.async {
                      NIUIHelper.sharedInstance.showBannerMessage(NetworkResponse.someErrorOccuredString.rawValue, isSuccess: .error)
                    }
                    break
                    
                default:
                    break
                }
            }
        }
    }
    
    static func getApiStatus(_ response: HTTPURLResponse) -> (Result<String>, statusCode:Int){
        let code = response.statusCode
        switch code{
          case 200...299: return (.success, response.statusCode)
          default: return (.failure, response.statusCode)
        }
    }
}


