//
//  ImageDetailsViewController.swift
//  ControlAcademicMaster
//
//  Created by Cloud Technologys Center on 3/10/17.
//  Copyright © 2017 Cloud Technologys Center. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageDetailsViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var imageDetail: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var closeButton: UIButton!
    
    var urlImg = String()
    var detailData = NSData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.layer.cornerRadius = 17.5
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4.0
        
        if urlImg != "" {
            
            let uslString = String(format: "https://image.tmdb.org/t/p/w500%@", urlImg)
            
            let URL = NSURL(string: uslString)
            imageDetail.af_setImage(withURL: URL! as URL)
        }else{
            imageDetail.image = UIImage(data:detailData as Data)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageDetail
    }

    @IBAction func closeImage(_ sender: Any) {
        UIView.animate(withDuration: 0.9, animations: {
            UIApplication.shared.isStatusBarHidden = false
            self.dismiss(animated: true, completion: nil)
        })
    }
}
