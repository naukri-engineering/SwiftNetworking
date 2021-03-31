//
//  FileUploaderTaskObserver.swift
//  NaukriIndia
//
//  Created by Himanshu Gupta on 09/03/21.
//  Copyright © 2021 Info Edge India Ltd. All rights reserved.
//

import Foundation
typealias PercentageValue = Double
typealias ProgressHandler = (PercentageValue) -> Void
typealias DownloadCompletionHandler = (Bool, Data?) -> Void

class FileUploaderTaskObserver: NSObject {
    var progressHandlersByTaskID = [Int : ProgressHandler]()
    var completionHandler = [Int : DownloadCompletionHandler]()
    func readDownloadedData(of url: URL) -> Data? {
            do {
                let reader = try FileHandle(forReadingFrom: url)
                let data = reader.readDataToEndOfFile()
                return data
            } catch {
                print(error)
                return nil
            }
        }

}
extension FileUploaderTaskObserver: URLSessionTaskDelegate , URLSessionDownloadDelegate{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let handler = completionHandler[downloadTask.taskIdentifier]
        if let data = self.readDownloadedData(of: location){
            handler?(true, data)
        }
    }
    func urlSession(_ session: URLSession,task: URLSessionTask,didSendBodyData bytesSent: Int64,totalBytesSent: Int64,totalBytesExpectedToSend: Int64) {
            let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
            let handler = progressHandlersByTaskID[task.taskIdentifier]
            handler?(progress)
        }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        let handler = progressHandlersByTaskID[downloadTask.taskIdentifier]
        handler?(progress)
    }
    

}
extension FileUploaderTaskObserver: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, urlCredential)
    }

}
