//
//  ResponseMessage.swift
//  NaukriIndia
//
//  Created by Himanshu Gupta on 03/08/18.
//  Copyright © 2018 Info Edge India Ltd. All rights reserved.
//

import Foundation

public enum NetworkResponse:String {
    case NoNetworkConnection = "No Internet Connection"
    case RequestTimedOut = "The request timed out"
    case sslErrorMessage = "Error while fetching data. Ensure phone date and time are correct and try connecting again."
    case someErrorOccuredString = "Some error occured. Please try again"
    case connectionNotestablished = "Connection could not be established, Please try again later"
    case badRequestMessage = "The request seems to be Incorrect"
    case unAuthorizedMessage = "Unauthorised Access. Please try to login again"
    case notFoundMessage = "The resource you are looking for does not exist"
    case serverErrorMessage = "There is some issue in acccessing the server. Please try again"

}
enum StatusCodeResult: Int {
    case success = 200
    case created = 201
    case noContent = 204
    case badRequest = 400
    case unAuthorized = 401
    case notFound = 404
    case forbidden = 403
    case serverError = 500
    case serverGatewayError = 504
    case serviceUnavailable = 503
    case unknown = -1
}

public enum NetworkRequest:String {
    case requestFailed = "Could not build the Network Request"
}
