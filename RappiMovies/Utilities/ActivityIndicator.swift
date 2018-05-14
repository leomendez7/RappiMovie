//
//  ActivityIndicator.swift
//  SIAN
//
//  Created by Cloud Technologys Center on 2/03/18.
//  Copyright © 2018 Cloud Technologys Center. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicator {
    
    static let shared = ActivityIndicator()
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let backgroud = UIView()
    
    func startSpinnerAnimation(message: String){
        let view:UIWindow = UIApplication.shared.delegate!.window!!
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = message
        strLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        strLabel.numberOfLines = 2
        strLabel.textColor = UIColor(white: 1, alpha: 0.9)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: strLabel.frame.height)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        backgroud.frame = CGRect(x: 0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        backgroud.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        backgroud.addSubview(effectView)
        view.addSubview(backgroud)
    }
    
    func stopSpinnerAnimation(){
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        backgroud.removeFromSuperview()
    }
}
