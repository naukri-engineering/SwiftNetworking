//
//  NISWLoader.swift
//  Naukri
//
//  Created by Himanshu Gupta on 21/09/18.
//  Copyright © 2018 Infoedge. All rights reserved.
//

import UIKit
class NISWLoader: UIView {

    public var isLoaderAvail : Bool?
    public var isViewAddedOnWindow : Bool?

    private var animatorBaseView: UIView?
    private var rotatingImageView: UIImageView?
    private var logoImageView: UIImageView?
    private var loaderLable: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Initialization code
        isLoaderAvail = false
        isViewAddedOnWindow = false
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showAnimator(_ showView: UIView?, belowNavigtionBar: Bool = false) {
        if let shoWView = showView{
        frame = shoWView.frame
        if animatorBaseView == nil {
            animatorBaseView = UIView(frame: CGRect(x: (frame.size.width * 0.5) - 25, y: (frame.size.height * 0.5) - 25, width: 50, height: 50))
            animatorBaseView!.backgroundColor = UIColor.clear
        }
        if rotatingImageView == nil {
            rotatingImageView = UIImageView(image: UIImage(named: "loader_back"))
            rotatingImageView!.frame = CGRect(x: 3, y: 3, width: 44, height: 44)
            animatorBaseView!.addSubview(rotatingImageView!)
        }
        
        var rotationAnimation: CABasicAnimation?
        rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation?.toValue = .pi * 2.0 * 2 * 60.0
        rotationAnimation?.duration = 60.0
        rotationAnimation?.isCumulative = true
        rotationAnimation?.repeatCount = .infinity
        if let anAnimation = rotationAnimation {
            rotatingImageView!.layer.add(anAnimation, forKey: "rotationAnimation")
        }
        if logoImageView == nil {
            logoImageView = UIImageView(image: UIImage(named: "loader_front"))
            logoImageView!.frame = CGRect(x: 3, y: 3, width: 44, height: 44)
            animatorBaseView!.addSubview(logoImageView!)
        }
        

        if(belowNavigtionBar == true){
            let topBarHeight = UIApplication.shared.statusBarFrame.size.height + 44
            let rect = CGRect(x: self.frame.origin.y, y: topBarHeight, width: self.frame.size.width, height: self.frame.size.height - topBarHeight)
            self.frame = rect
            self.backgroundColor = UIColor.red
        }
        addSubview(animatorBaseView!)
        shoWView.addSubview(self)
        isLoaderAvail = true
        
        //Adding the View on Window.
        if let isViewAddedOnWindow1 = isViewAddedOnWindow, isViewAddedOnWindow1 == true {
            backgroundColor = UIColor.white
            let appDelegate = UIApplication.shared.delegate!
            appDelegate.window??.addSubview(self)
        }
     }
    }
    func showAnimation(_ shoWView: UIView?) {
        if animatorBaseView == nil {
            animatorBaseView = UIView()
            animatorBaseView!.translatesAutoresizingMaskIntoConstraints = false
        }
        if rotatingImageView == nil {
            
            rotatingImageView = UIImageView(image: UIImage(named: "loader_back"))
            rotatingImageView!.translatesAutoresizingMaskIntoConstraints = false
            animatorBaseView!.addSubview(rotatingImageView!)
        }
        if logoImageView == nil {
            
            logoImageView = UIImageView(image: UIImage(named: "loader_front"))
            logoImageView!.translatesAutoresizingMaskIntoConstraints = false
            animatorBaseView!.addSubview(logoImageView!)
        }
        
        addSubview(animatorBaseView!)
        shoWView?.addSubview(self)
        
        shoWView?.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: shoWView, attribute: .leading, multiplier: 1.0, constant: 0))
        shoWView?.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: shoWView, attribute: .top, multiplier: 1.0, constant: 0))
        shoWView?.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: shoWView, attribute: .width, multiplier: 1.0, constant: 0))
        
        shoWView?.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: shoWView, attribute: .height, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: animatorBaseView!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: animatorBaseView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        animatorBaseView!.addConstraint(NSLayoutConstraint(item: animatorBaseView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 50))
        animatorBaseView!.addConstraint(NSLayoutConstraint(item: animatorBaseView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 50))
        animatorBaseView!.addConstraint(NSLayoutConstraint(item: animatorBaseView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 50))
        
        
        
        rotatingImageView!.addConstraint(NSLayoutConstraint(item: rotatingImageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 44))
        rotatingImageView!.addConstraint(NSLayoutConstraint(item: rotatingImageView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 44))
        
        animatorBaseView!.addConstraint(NSLayoutConstraint(item: rotatingImageView!, attribute: .centerX, relatedBy: .equal, toItem: animatorBaseView!, attribute: .centerX, multiplier: 1.0, constant: 0))
        animatorBaseView!.addConstraint(NSLayoutConstraint(item: rotatingImageView!, attribute: .centerY, relatedBy: .equal, toItem: animatorBaseView!, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        
        logoImageView!.addConstraint(NSLayoutConstraint(item: logoImageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 44))
        logoImageView!.addConstraint(NSLayoutConstraint(item: logoImageView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 44))
        animatorBaseView!.addConstraint(NSLayoutConstraint(item: logoImageView!, attribute: .centerX, relatedBy: .equal, toItem: animatorBaseView!, attribute: .centerX, multiplier: 1.0, constant: 0))
        animatorBaseView!.addConstraint(NSLayoutConstraint(item: logoImageView!, attribute: .centerY, relatedBy: .equal, toItem: animatorBaseView!, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        var rotationAnimation: CABasicAnimation?
        rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation!.toValue = .pi * 2.0 * 2 * 60.0
        rotationAnimation!.duration = 60.0
        rotationAnimation!.isCumulative = true
        rotationAnimation!.repeatCount = .infinity
        rotatingImageView!.layer.add(rotationAnimation!, forKey: "rotationAnimation")
        
        isLoaderAvail = true
        if let isViewAddedOnWindow1 = isViewAddedOnWindow, isViewAddedOnWindow1 == true {
            backgroundColor = UIColor.white
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.addSubview(self)
        }
    
   }
    func showAnimatorOnWindow(withMessage textStr: String?) {
        let appDelegate = UIApplication.shared.delegate
        frame = (appDelegate?.window??.frame)!
        if animatorBaseView == nil {
            animatorBaseView = UIView(frame: CGRect(x: (frame.size.width * 0.5) - 100, y: (frame.size.height * 0.5) - 100, width: 200, height: 200))
            animatorBaseView!.backgroundColor = UIColor.clear
        }
        
        
        if loaderLable == nil {
            loaderLable = UILabel()
            loaderLable!.font = UIFont.systemFont(ofSize: 16.0)
            loaderLable!.textColor = UIColor.black
            loaderLable!.backgroundColor = UIColor.clear
        }
        
        
        if textStr != nil {
            if !UIAccessibility.isReduceTransparencyEnabled {
                var blurEffect = UIBlurEffect()
                if #available(iOS 10.0, *) {
                    blurEffect = UIBlurEffect(style: .regular)
                } else {
                    // Fallback on earlier versions
                    blurEffect = UIBlurEffect(style: .light)
                }
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.layer.cornerRadius = 30.0
                blurEffectView.clipsToBounds = true
                blurEffectView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                animatorBaseView!.addSubview(blurEffectView)
                
                let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
                let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
                vibrancyEffectView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                vibrancyEffectView.contentView.addSubview(loaderLable!)
                animatorBaseView!.addSubview(vibrancyEffectView)
            } else {
                animatorBaseView!.addSubview(loaderLable!)
                animatorBaseView!.backgroundColor = UIColor(white: 1.0, alpha: 0.85)
                animatorBaseView!.layer.cornerRadius = 30.0
                animatorBaseView!.layer.borderWidth = 1.0
                animatorBaseView!.layer.borderColor = UIColor(white: 0.4, alpha: 0.85).cgColor
            }
            loaderLable!.text = textStr
            loaderLable!.numberOfLines = 0
            loaderLable!.frame = CGRect(x: 0, y: 125, width: 200, height: 75)
            loaderLable!.textAlignment = .center
            
        }
        if rotatingImageView == nil {
            rotatingImageView = UIImageView(image: UIImage(named: "loader_back"))
            rotatingImageView!.frame = CGRect(x: 78, y: 78, width: 44, height: 44)
            animatorBaseView!.addSubview(rotatingImageView!)
        }
        
        var rotationAnimation: CABasicAnimation?
        rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation!.toValue = .pi * 2.0 * 2 * 60.0
        rotationAnimation!.duration = 60.0
        rotationAnimation!.isCumulative = true
        rotationAnimation!.repeatCount = .infinity
        if let anAnimation = rotationAnimation {
            rotatingImageView!.layer.add(anAnimation, forKey: "rotationAnimation")
        }
        if logoImageView == nil {
            
            logoImageView = UIImageView(image: UIImage(named: "loader_front"))
            logoImageView!.frame = CGRect(x: 78, y: 78, width: 44, height: 44)
            animatorBaseView!.addSubview(logoImageView!)
        }
        
        backgroundColor = UIColor.clear
        addSubview(animatorBaseView!)
        appDelegate?.window??.addSubview(self)
        appDelegate?.window??.bringSubviewToFront(self)
        isLoaderAvail = true
    }
    func hideAnimatorFromWindow() {
        if(self.isLoaderAvail == false){
            return;
        }
        rotatingImageView?.layer.removeAnimation(forKey: "rotationAnimation")
        animatorBaseView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        animatorBaseView?.layer.position = animatorBaseView!.center
        
        
        let center: CGPoint = (animatorBaseView != nil) ? animatorBaseView!.center : CGPoint.zero

        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.animatorBaseView?.center = center
            self.animatorBaseView?.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            self.animatorBaseView?.alpha = 0.0
            
        }) { finished in
            self.rotatingImageView?.removeFromSuperview()
            self.rotatingImageView?.image = nil
            self.rotatingImageView = nil

            self.logoImageView?.removeFromSuperview()
            self.logoImageView?.image = nil
            self.logoImageView = nil
            
            self.loaderLable?.removeFromSuperview()
            self.loaderLable = nil
            self.animatorBaseView?.removeFromSuperview()
            self.animatorBaseView = nil
            
            self.isLoaderAvail = false
            self.removeFromSuperview()
        }
    }
    func hideAnimator() {
        if(self.isLoaderAvail == false){
            return;
        }
        self.rotatingImageView?.layer.removeAnimation(forKey: "rotationAnimation")
        animatorBaseView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        animatorBaseView?.layer.position = animatorBaseView!.center
        
        let center: CGPoint = (animatorBaseView != nil) ? animatorBaseView!.center : CGPoint.zero
        
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.animatorBaseView?.center = center
            self.animatorBaseView?.alpha = 0.0
            
        }) { finished in
            self.rotatingImageView?.removeFromSuperview()
            self.rotatingImageView?.image = nil
            self.rotatingImageView = nil
            self.logoImageView?.removeFromSuperview()
            self.logoImageView?.image = nil
            self.logoImageView = nil
            self.animatorBaseView?.removeFromSuperview()
            self.animatorBaseView = nil
            self.isLoaderAvail = false
            self.removeFromSuperview()
        }
    }

}
