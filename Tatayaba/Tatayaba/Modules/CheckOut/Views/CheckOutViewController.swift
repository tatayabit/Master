//
//  CheckOutViewController.swift
//  Tatayaba
//
//  Created by Admin on 19/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CheckOutViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet var PaymentcollectionView: UICollectionView!
    @IBOutlet weak var subTotalValueLabel: UILabel!
    @IBOutlet weak var shippingValueLabel: UILabel!
    @IBOutlet weak var vatValueLabel: UILabel!
    @IBOutlet weak var totalPriceButton: UIButton!

    private let viewModel = CheckOutViewModel()

    let checkoutCompletedSegue = "checkout_completed_segue"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.updateData()
    }

    func updateData() {
        subTotalValueLabel.text = viewModel.subTotalValue
        totalPriceButton.setTitle(viewModel.totalValue, for: .normal)
        shippingValueLabel.text = viewModel.shippingValue
    }
    
    
    func setupUI() {
        self.NavigationBarWithOutBackButton()

        self.PaymentcollectionView.register(PaymentSelectionViewCell.nib, forCellWithReuseIdentifier: PaymentSelectionViewCell.identifier)
        
    }

    //MARK:- IBActions

    @IBAction func totalPriceAction(_ sender: Any) {
        viewModel.placeOrder { result in
            switch result {
            case .success(let response):
                guard let placeOrderResult = response else { return }
                //                guard let paymentMethods = paymentResult.paymentMethods else { return }

                print(placeOrderResult)
                if placeOrderResult.orderId > 0 {
                    self.performSegue(withIdentifier: self.checkoutCompletedSegue, sender: nil)
                } else {
                    print("the error order id == \(placeOrderResult.orderId)")
                }

            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
}

/// Collection View
extension CheckOutViewController{
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return 09
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentSelectionViewCell.identifier, for: indexPath) as! PaymentSelectionViewCell
        cell.layer.borderColor = UIColor.brandBrown.cgColor
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 07, left: 10, bottom: 07, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}
