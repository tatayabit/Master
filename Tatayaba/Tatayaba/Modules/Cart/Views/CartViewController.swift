//
//  CartViewController.swift
//  Tatayaba
//
//  Created by Admin on 15/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CartViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    let EditBtn = UIButton()
    let EditOkBtn = UIButton()
    var EditButton = String()
    let cart = Cart.shared

    private let checkoutSegue = "checkout_segue"


    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var cart_Tableview: UITableView!
    @IBOutlet weak var totalButton: UIButton!

    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        EditButton = "0"
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cart_Tableview.reloadData()
        //totalButton.setTitle(cart.subtotalPrice, for: .normal)
    }

    func setupUI() {
         self.NavigationBarWithOutBackButton()
         self.addLeftBarButton()
        // self.collectionView.register(RecommendedCollectionViewCell.nib, forCellWithReuseIdentifier: RecommendedCollectionViewCell.identifier)

    }

   

  

    //MARK:- IBActions
    @IBAction func checkoutAction(_ sender: Any) {
        performSegue(withIdentifier: checkoutSegue, sender: nil)
    }

    //MARK:- Add / Remove Cell Actions
    func addOneMoreAction(indexPath: IndexPath) {
        let cartProduct = cart.product(at: indexPath)
        cart.increaseCount(cartItem: cartProduct.1)
//        cart_Tableview.reloadRows(at: [indexPath], with: .automatic)
        totalButton.setTitle(cart.subtotalPrice, for: .normal)

    }

    func removeOneAction(indexPath: IndexPath) {
        let cartProduct = cart.product(at: indexPath)
        cart.decreaseCount(cartItem: cartProduct.1)
//        cart_Tableview.reloadRows(at: [indexPath], with: .automatic)
        totalButton.setTitle(cart.subtotalPrice, for: .normal)

    }

    func removeItemAction(indexPath: IndexPath) {
        let cartProduct = cart.product(at: indexPath)
        cart.removeProduct(cartItem: cartProduct.1)
        totalButton.setTitle(cart.subtotalPrice, for: .normal)

//        cart_Tableview.reloadRows(at: [indexPath], with: .automatic)
    }

}
 //Tableview
extension CartViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CartCellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CartTableViewCell

//        let cartProduct = cart.product(at: indexPath)
//        cell.configure(product: cartProduct.0, cartItem: cartProduct.1)
//
//        cell.onAddMoreClick = {
//            self.addOneMoreAction(indexPath: indexPath)
//            cell.updatePrice(product: cartProduct.0, cartItem: cartProduct.1)
//        }
//
//        cell.onRemoveOneCountClick = {
//            self.removeOneAction(indexPath: indexPath)
//            cell.updatePrice(product: cartProduct.0, cartItem: cartProduct.1)
//        }
//
//        cell.onRemoveItemClick = {
//            self.removeItemAction(indexPath: indexPath)
//            cell.updatePrice(product: cartProduct.0, cartItem: cartProduct.1)
//        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
/// Collection View
extension CartViewController{

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return 10
}


    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedCollectionViewCell.identifier, for: indexPath) as! RecommendedCollectionViewCell


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


    }
}
