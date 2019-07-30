//
//  HomeViewController.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController,AACarouselDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let buttonPadding:CGFloat = 05
    var xOffset:CGFloat = 15
    private let productDetailsSegue = "product_details_segue"

    @IBOutlet weak internal var collectionView: UICollectionView!
    @IBOutlet weak var carouselView: AACarousel!

    @IBOutlet var Categories_Scroll: UIScrollView!
    private var viewModel = HomeViewModel()

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupListners()
  
    }
   
    
    func setupListners() {
        viewModel.onCategoriesListLoad = {

        }

        viewModel.onFeaturedProductsListLoad = {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.reloadData()
        }
    }
    func downloadImages(_ url: String, _ index: Int) {

    }

    // MARK:- SetupUI
    func setupUI() {
        self.addLeftBarButton()
        self.NavigationBarWithOutBackButton()
        self.collectionView.register(FeatureProductCollectionViewCell.nib, forCellWithReuseIdentifier: FeatureProductCollectionViewCell.identifier)
        carousel()
        CategoriesView()
    }
    
    
    func CategoriesView(){
        Categories_Scroll.translatesAutoresizingMaskIntoConstraints = false
    
        for i in 0 ... 10{
            let button = UIButton()
            button.tag = i
            button.backgroundColor = UIColor.darkGray
            button.setTitle("\(i)", for: .normal)
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            button.layer.borderColor = UIColor.brandBrown.cgColor
            button.layer.borderWidth = 2.0 //
            button.setImage(UIImage(named: "perfume_image"), for: .normal)
            button.clipsToBounds = true
            button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 70, height: 70)
            
            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width+15
            Categories_Scroll.addSubview(button)
            button.layer.cornerRadius = button.frame.width/2
            
        }
        Categories_Scroll.contentSize = CGSize(width: xOffset, height: Categories_Scroll.frame.height)
        
      
     
        
    }
    
    

    func carousel() {

        let pathArray = ["Dashboard",
                         "ADD",
                         "Dashboard",
                         "ADD"]
        carouselView.delegate = self

        carouselView.setCarouselData(paths: pathArray,  describedTitle: [""], isAutoScroll: false, timer: 1.5 , defaultImage: "ADD")

        carouselView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
        carouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
       
    }
}

extension HomeViewController {
    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return viewModel.featuredProductsCount
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureProductCollectionViewCell.identifier, for: indexPath) as! FeatureProductCollectionViewCell
        cell.configure(product: viewModel.featuredProduct(at: indexPath))

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 02, left: 0, bottom: 07, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print(indexPath.row)

        performSegue(withIdentifier: productDetailsSegue, sender: indexPath)

    }

    //MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == productDetailsSegue {
            let productDetailsVC = segue.destination as! ProductDetailsViewController
            if let indexPath = sender as? IndexPath {
                productDetailsVC.viewModel = viewModel.productDetailsViewModel(at: indexPath)
            }
        }
    }

}

