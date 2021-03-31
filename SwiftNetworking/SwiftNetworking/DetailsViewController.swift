//
//  DetailsViewController.swift
//  SwiftNetworking
//
//  Created by Himanshu Gupta on 28/03/21.
//

import UIKit
import AVKit
class DetailsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var apiResponse: APIRESPONSE?
    var type: cellType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.callApi()
    }
    func callApi(){
        guard let type = self.type else {
            return
        }
        self.spinner.startAnimating()
        switch type {
        case .get:
            self.testGetApiCall { (success) in
                DispatchQueue.main.async {
                    self.updatePage()
                }
            }
            break
        case .post:
            self.testPostApiCall { (success) in
                DispatchQueue.main.async {
                    self.updatePage()
                }
            }
            break
        case .put:
            self.testPutApiCall { (success) in
                DispatchQueue.main.async {
                    self.updatePage()
                }
            }
            break
        case .delete:
            self.testDeleteApiCall { (success) in
                DispatchQueue.main.async {
                    self.updatePage()
                }
            }
        case .getWithQuery:
            self.testGetWithQueryApiCall { (success) in
                DispatchQueue.main.async {
                    self.updatePage()
                }
            }
        case .postWithQuery:
            self.testPostWithQueryApiCall { (success) in
                DispatchQueue.main.async {
                    self.updatePage()
                }
            }
            break
        case .mulitpartUpload:
            self.testMultipartApiCall { (success) in
                DispatchQueue.main.async {
                    self.updatePage()
                }
            }
            break
        
        }
    }
   
}
extension DetailsViewController{
    func testGetApiCall(completionHandler:@escaping(_ isSucessFull : Bool)->()){
        let router = Router<SampleEndPoints>()
        router.request(.get) { (response) in
            self.apiResponse = response
            completionHandler(response.isSuccess)
        }
    }
    func testPostApiCall(completionHandler:@escaping(_ isSucessFull : Bool)->()){
        let router = Router<SampleEndPoints>()
        router.request(.post(parameters: [postDataKey:["name":"Robert","age":"32"]])) { (response) in
            self.apiResponse = response
            completionHandler(response.isSuccess)
        }
    }
    func testPutApiCall(completionHandler:@escaping(_ isSucessFull : Bool)->()){
        let router = Router<SampleEndPoints>()
        router.request(.put(parameters: [postDataKey:["name":"Robert","age":"32"]])) { (response) in
            self.apiResponse = response
            completionHandler(response.isSuccess)
        }
    }
    func testDeleteApiCall(completionHandler:@escaping(_ isSucessFull : Bool)->()){
        let router = Router<SampleEndPoints>()
        router.request(.delete(parameters: [postDataKey:["id":"32"]])) { (response) in
            self.apiResponse = response
            completionHandler(response.isSuccess)
        }
    }
    func testGetWithQueryApiCall(completionHandler:@escaping(_ isSucessFull : Bool)->()){
        let router = Router<SampleEndPoints>()
        router.request(.getWithQuery(parameters: [queryDataKey:["id":"32"]])) { (response) in
            self.apiResponse = response
            completionHandler(response.isSuccess)
        }
    }
    func testPostWithQueryApiCall(completionHandler:@escaping(_ isSucessFull : Bool)->()){
        let router = Router<SampleEndPoints>()
        router.request(.postWithQuery(parameters: [postDataKey:["name":"Robert Downey"], queryDataKey:["id":"33"]])) { (response) in
            self.apiResponse = response
            completionHandler(response.isSuccess)
        }
    }
    func testMultipartApiCall(completionHandler:@escaping(_ isSucessFull : Bool)->()){
        
        var mediaData = mediaContent()
        
        //test for Image file
        if let imageData =  UIImage(named: "test.png")?.pngData(){
            mediaData.data = imageData
            mediaData.mimeType = mimeTypeEnum.pngImage
            mediaData.fileName = "image.png"
        }
        
//        //test for document
//        if let asset = NSDataAsset(name: "resume"){
//            mediaData.data = asset.data
//            mediaData.mimeType = mimeTypeEnum.documentType
//            mediaData.fileName = "resume.pdf"
//        }
        
        //test for video
//        if let url = Bundle.main.url(forResource: "test", withExtension: "mp4"){
//            var videoData : Data?
//            do {
//                videoData = try Data(contentsOf: url)
//            } catch {
//                print("no video file found")
//            }
//            mediaData.data = videoData
//            mediaData.mimeType = mimeTypeEnum.documentType
//            mediaData.fileName = "video.mp4"
//        }
        
        let router = Router<SampleEndPoints>()
        router.request(.multipartUpload(parameters: [multipartDataKey:mediaData])) { (response) in
            self.apiResponse = response
            completionHandler(response.isSuccess)
        }
    }

}
extension DetailsViewController{
    func updatePage(){
        self.spinner.stopAnimating()
        guard let response = self.apiResponse else {
            return
        }
        guard let request = self.apiResponse?.request else {
            return
        }
        let requestStr = "----------Outgoing Request----------\n".appending(NetworkLogger.log(request: request))
        let responseStr = "\n----------Incoming Response----------\n".appending(NetworkLogger.log(response: response))
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string:"\(requestStr):", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0),NSAttributedString.Key.foregroundColor: UIColor.blue]))
        attributedString.append(NSAttributedString(string:"\(responseStr):", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0),NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
        self.textView.attributedText = attributedString
    }
}
