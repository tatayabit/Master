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
    let productOptionsView: ProductOptionsView = .fromNib()
    var priceButton: UIButton = UIButton(type: .custom)

    var viewModel: ProductDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSubViews()
    }

    func addSubViews() {
        setupProductDetailsView()
        setupOptionsView()
        setupPriceButton()
    }

    fileprivate func setupProductDetailsView() {
        productDetailsView.viewModel = viewModel
        productDetailsView.loadData()
        scrollView.stackView.addArrangedSubview(productDetailsView)
        productDetailsView.translatesAutoresizingMaskIntoConstraints = false
        productDetailsView.heightAnchor.constraint(equalToConstant: 376).isActive = true
    }

    fileprivate func setupOptionsView() {
        productOptionsView.viewModel = viewModel
//        productOptionsView.loadData()
        scrollView.stackView.addArrangedSubview(productOptionsView)
        productOptionsView.translatesAutoresizingMaskIntoConstraints = false
        productOptionsView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    fileprivate func setupPriceButton() {
        guard let viewModel = viewModel else { return }

        let containerView = UIView()
        scrollView.stackView.addArrangedSubview(containerView)

        priceButton.setBackgroundImage(UIImage(named: "price _rounded_rectangle"), for: .normal)
        priceButton.setTitleColor(.brandDarkBlue, for: .normal)
        priceButton.setTitle(viewModel.price, for: .normal)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        containerView.centerXAnchor.constraint(equalTo: scrollView.stackView.centerXAnchor).isActive = true

        containerView.addSubview(priceButton)

        priceButton.translatesAutoresizingMaskIntoConstraints = false
        priceButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        priceButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        priceButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }

    //MARK:- AACarouselDelegate
    func downloadImages(_ url: String, _ index: Int) {

    }

}
