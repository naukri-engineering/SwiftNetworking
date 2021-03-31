//
//  NIUIHelper.swift
//  NaukriIndia
//
//  Created by Himanshu Gupta on 11/02/19.
//  Copyright © 2019 Info Edge India Ltd. All rights reserved.
//

import UIKit
enum bannerType:Int{
    case success
    case information
    case error

}
class NIUIHelper: NSObject {
    static let sharedInstance = NIUIHelper()
    var loader :  NISWLoader?

    func showBannerMessage(_ title: String?, isSuccess: bannerType,bannerDuration: TimeInterval? = 3.0) {
        DispatchQueue.main.async {
            let bannerTitle = title == nil ? "" : title!
            
            var separatorColor = UIColor.white
            
            switch isSuccess{
            case .success:
                separatorColor = UIColor(red: 55.0/255, green: 194.0/255, blue: 141.0/255, alpha: 1.0)
                break
                
            case .information:
                separatorColor = UIColor(red: 255.0/255, green: 171.0/255, blue: 0.0/255, alpha: 1.0)
                
                break
                
            case .error:
                separatorColor = UIColor(red: 232.0/255, green: 86.0/255, blue: 87.0/255, alpha: 1.0)
                break
                
            }
            
            let banner = NISwiftBanner(title: "", subtitle: bannerTitle, image: nil,separatorColor: separatorColor )
            banner.titleLabel.font = UIFont.systemFont(ofSize:14.0)
            banner.dismissesOnTap = true
            banner.show(duration: bannerDuration)
        }
    }
    func showLoader() {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate
            if self.loader == nil {
                let loaderFrame: CGRect = (appDelegate?.window??.frame)!
                self.loader = NISWLoader(frame: loaderFrame)
            }
            self.loader!.showAnimator(appDelegate?.window??.superview)
        }
    }
    func hideLoader() {
        DispatchQueue.main.async {
            if self.loader?.isLoaderAvail == true {
                self.loader!.hideAnimator()
                self.loader = nil
            }
        }
    }
}
