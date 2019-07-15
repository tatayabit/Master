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


    @IBOutlet var recommended_Scrollview: UIScrollView!
    @IBOutlet var product_ScrollView: UIScrollView!
    @IBOutlet weak var ProductcarouselView: AACarousel!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!

    @IBOutlet var favoriteButton: UIButton!


    let buttonPadding:CGFloat = 25
    var xOffset:CGFloat = 10


    var viewModel: ProductDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // self.NavigationBarWithOutBackButton()
        self.carousel()
        self.FeatureProducts()
        self.RecomandedProducts()
        self.loadData()
    }

    //MARK:- Load Data
    func loadData() {
        guard let viewModel = viewModel else { return }
        priceButton.setTitle(viewModel.price, for: .normal)
        descriptionLabel.text = viewModel.description
        quantityLabel.text = String(viewModel.selectedQuantity)

    }


    func FeatureProducts(){


//        product_ScrollView.backgroundColor = .red


        product_ScrollView.translatesAutoresizingMaskIntoConstraints = false

        for i in 0 ... 10{
            let button = UIButton()
            button.tag = i
            button.backgroundColor = UIColor.darkGray
//            button.setTitle("\(i)", for: .normal)
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            button.clipsToBounds = true
            button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 70, height: 70)
//            button.layer.borderColor = UIColor.brandBrown.cgColor
            button.layer.borderWidth = 0.0 //

            button.setImage(UIImage(named: "perfume_image"), for: .normal)

            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            product_ScrollView.addSubview(button)
            button.layer.cornerRadius = button.frame.width/2

        }
        product_ScrollView.contentSize = CGSize(width: xOffset, height: product_ScrollView.frame.height)

    }



    func RecomandedProducts(){


        recommended_Scrollview.backgroundColor = .red


        recommended_Scrollview.translatesAutoresizingMaskIntoConstraints = false

        for i in 0 ... 10{
            let button = UIButton()
            button.tag = i
            button.backgroundColor = UIColor.darkGray
            button.setTitle("", for: .normal)
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 70, height: 70)

            button.layer.borderWidth = 2.0 //
            button.setImage(UIImage(named: "perfume_image"), for: .normal)
            button.clipsToBounds = true


            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            recommended_Scrollview.addSubview(button)


        }
        recommended_Scrollview.contentSize = CGSize(width: xOffset, height: recommended_Scrollview.frame.height)


//        for i in 0 ... 10 {
//            let button = UIButton()
//            button.tag = i
//            button.backgroundColor = UIColor.darkGray
//            button.setTitle("\(i)", for: .normal)
//            button.layer.cornerRadius = 0.5 * button.bounds.size.width
//            let brown = UIColor.brandBrown
//            button.layer.borderColor = brown.cgColor
//            button.layer.borderWidth = 2.0 //
//            button.setImage(UIImage(named: "perfume_image"), for: .normal)
//            button.clipsToBounds = true
//            button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 70, height: 70)
//
//            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width+15
//            Categories_Scroll.addSubview(button)
//            button.layer.cornerRadius = button.frame.width/2
//
//        }
//        Categories_Scroll.contentSize = CGSize(width: xOffset, height: Categories_Scroll.frame.height)

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

    //MARK:- IBActions
    @IBAction func increaseQuantity(_ sender: UIButton) {
        viewModel?.increase()
        quantityLabel.text = String(viewModel!.selectedQuantity)
    }

    @IBAction func decreaseQuantity(_ sender: UIButton) {
        viewModel?.decrease()
        quantityLabel.text = String(viewModel!.selectedQuantity)
    }

}
