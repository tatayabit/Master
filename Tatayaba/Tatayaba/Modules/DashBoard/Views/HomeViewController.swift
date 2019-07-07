//
//  HomeViewController.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController,AACarouselDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
  @IBOutlet weak internal var collectionView: UICollectionView!
    
    @IBOutlet weak var carouselView: AACarousel!
    func downloadImages(_ url: String, _ index: Int) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLeftBarButton()
      self.NavigationBarWithOutBackButton()
        self.collectionView.register(FeatureProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCollectionViewCell")
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
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

extension HomeViewController {

func collectionView(_ collectionView: UICollectionView,
                    numberOfItemsInSection section: Int) -> Int {
    
        return 5
    
    
}
func collectionView(_ collectionView: UICollectionView,
                    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
 
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! FeatureProductCollectionViewCell
    
 cell.backgroundColor = .gray
  
    return cell
}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 05, left: 0, bottom: 05, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        self.pushToNextViewController(storyboardName: "ProductDetails", segueName: "ProductViewController")
        
        
        
    }
    
}

