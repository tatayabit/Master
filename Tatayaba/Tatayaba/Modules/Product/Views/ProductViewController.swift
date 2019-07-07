//
//  ProductViewController.swift
//  Tatayaba
//
//  Created by Admin on 07/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController,AACarouselDelegate {
    func downloadImages(_ url: String, _ index: Int) {
        
    }
    
    
    @IBOutlet var product_ScrollView: UIScrollView!
    let buttonPadding:CGFloat = 25
    var xOffset:CGFloat = 10
    
     @IBOutlet weak var ProductcarouselView: AACarousel!

    override func viewDidLoad() {
        super.viewDidLoad()
    self.NavigationBarWithOutBackButton()
       self.carousel()
        self.FeatureProducts()
        
       
    }
    
    
    func FeatureProducts(){
        
       
        product_ScrollView.backgroundColor = .red

        product_ScrollView.backgroundColor = UIColor.blue
        product_ScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 0 ... 10 {
            let button = UIButton()
            button.tag = i
            button.backgroundColor = UIColor.darkGray
            button.setTitle("\(i)", for: .normal)
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.borderWidth = 1.0
            button.clipsToBounds = true
            button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 70, height: 70)

            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            product_ScrollView.addSubview(button)
            button.layer.cornerRadius = button.frame.width/2
            
        }
    product_ScrollView.contentSize = CGSize(width: xOffset, height: product_ScrollView.frame.height)
   
}
  func carousel() {
    
    let pathArray = ["Dashboard",
                         "ADD",
                         "Dashboard",
                         "ADD"]
        ProductcarouselView.delegate = self
        ProductcarouselView.setCarouselData(paths: pathArray,  describedTitle: [""], isAutoScroll: true, timer: 1.5 , defaultImage: "Dashboard")
        ProductcarouselView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
        ProductcarouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    

 

}
