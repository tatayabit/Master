//
//  AboutUsViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/14/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseViewController, AACarouselDelegate {

    @IBOutlet weak var carouselView: AACarousel!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }


    // MARK:- SetupUI
    func setupUI() {
        self.NavigationBarWithOutBackButton()
        carousel()
    }


    func carousel() {

        let pathArray = ["Dashboard",
                         "ADD",
                         "Dashboard",
                         "ADD"]
        carouselView.delegate = self
        carouselView.setCarouselData(paths: pathArray,  describedTitle: [""], isAutoScroll: true, timer: 1.5 , defaultImage: "Dashboard")
        carouselView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
        carouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
    }

    func downloadImages(_ url: String, _ index: Int) {

    }
}
