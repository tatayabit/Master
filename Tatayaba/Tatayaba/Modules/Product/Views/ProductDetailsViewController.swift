//
//  ProductDetailsViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/17/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ProductDetailsViewController: BaseViewController, AACarouselDelegate {

    @IBOutlet weak var scrollView: StackedScrollView!
    let productDetailsView: ProductDetailsView = .fromNib()

    var viewModel: ProductDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSubViews()
    }

    func addSubViews() {
        setupProductDetailsView()
    }

    fileprivate func setupProductDetailsView() {
        productDetailsView.viewModel = viewModel
        scrollView.stackView.addArrangedSubview(productDetailsView)
        productDetailsView.translatesAutoresizingMaskIntoConstraints = false
        productDetailsView.heightAnchor.constraint(equalToConstant: 376).isActive = true
    }

    //MARK:- AACarouselDelegate
    func downloadImages(_ url: String, _ index: Int) {

    }

}
