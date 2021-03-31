//
//  MultiPartImageEncoder.swift
//  NaukriIndia
//
//  Created by Rahul Sharma on 11/06/19.
//  Copyright © 2019 Info Edge India Ltd. All rights reserved.
//


import Foundation

public struct MultiPartEncoder: ParameterEncoder {
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        let boundary = "---------------------------14737809831466499882746641449" ///some random boundary value
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let body = createBody(parameters: parameters,
                                boundary: boundary)
        urlRequest.setValue(String(body.count), forHTTPHeaderField:"Content-Length")
        urlRequest.httpBody = body

    }
    func createBody(parameters: [String: Any], boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        for (key, value) in parameters {
            if let tempValue = value as? String{
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(tempValue + lineBreak)")
            }
        }
        
        if let multipartData = parameters[multipartDataKey] as? mediaContent, let mimeType = multipartData.mimeType?.rawValue, let fileName = multipartData.fileName, let media = multipartData.data{
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\(lineBreak)")
            body.append("Content-Type: \(mimeType + lineBreak + lineBreak)")
            body.append(media)
            body.append(lineBreak)
        }
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
}
