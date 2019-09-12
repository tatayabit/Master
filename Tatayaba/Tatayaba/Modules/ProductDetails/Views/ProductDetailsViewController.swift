//
//  ProductDetailsViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/17/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ProductDetailsViewController: BaseViewController {

    @IBOutlet weak var scrollView: StackedScrollView!
    let productDetailsView: ProductDetailsView = .fromNib()
    let productOptionsView: ProductOptionsView = .fromNib()
    var priceButton: UIButton = UIButton(type: .custom)

    var viewModel: ProductDetailsViewModel?

    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSubViews()
    }

    //MARK:- Setup StackedScrollView
    func addSubViews() {
        scrollView.backgroundColor = UIColor(hexString: "#E9EBEC")
        scrollView.stackView.backgroundColor = UIColor(hexString: "#E9EBEC")
        setupProductDetailsView()
        setupOptionsView()
       // setupPriceButton()
    }



    fileprivate func setupProductDetailsView() {
        productDetailsView.viewModel = viewModel
        productDetailsView.loadData()
        scrollView.stackView.addArrangedSubview(productDetailsView)
        productDetailsView.translatesAutoresizingMaskIntoConstraints = false
        productDetailsView.heightAnchor.constraint(equalToConstant: 415).isActive = true
    }

    fileprivate func setupOptionsView() {
        productOptionsView.viewModel = viewModel
       scrollView.stackView.addArrangedSubview(productOptionsView)
        productOptionsView.translatesAutoresizingMaskIntoConstraints = false
        productOptionsView.heightAnchor.constraint(equalToConstant: 54).isActive = true
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
        priceButton.actionHandle(controlEvents: .touchUpInside) {
            self.addToCartAction()
        }
    }

    @IBAction func Add_Cart(_ sender: Any) {

        addToCartAction()
        let controller = UIStoryboard(name: "Cart", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewCartViewController") as! NewCartViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }
    //MARK:- IBActions
    func addToCartAction() {
        guard let viewModel = viewModel else { return }
        viewModel.addToCart()
    }

}
