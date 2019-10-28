//
//  ImageZoomViewController.swift
//  Tatayaba
//
//  Created by Ahmed Elsman on 10/28/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ImageZoomViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgPhoto: UIImageView!
    var productImage: String = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NavigationBarWithBackButton()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        imgPhoto.sd_setImage(with: URL(string: productImage), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
        // scrollView.delegate = self - it is set on the storyboard.
    }
    
    func viewForZooming(in scrxollView: UIScrollView) -> UIView? {
        
        return imgPhoto
    }

}
