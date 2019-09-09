//
//  RootViewController.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol RootViewControllerDelegate {
    func didSelectMenu(item: String)
}

class RootViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadFirstVC()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension RootViewController: RootViewControllerDelegate {
    
    func didSelectMenu(item: String) {
        switch item {
        case "HOME":
            self.loadHome()
        case "PROFILE":
            self.loadProfile()
        case "Login VC":
            self.loadFirstVC()
        case "Second VC":
            self.loadSecondVC()
        case "WISHLIST":
            self.loadWishList()
        case "ABOUT":
            self.loadAboutUs()
        case "MY ORDERS":
            self.loadOrdersVC()
        case "BRANDS":
            self.SuppliersList()
        case "MESSAGES":
            self.loadMessageVC()
        default:
            break
        }
    }

    func loadHome() {
        let controller = UIStoryboard(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }

    func loadProfile() {
        let controller = UIStoryboard(name: "User", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    func loadFirstVC() {
        let controller = UIStoryboard(name: "User", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(controller, animated: false)
      

    }
     func loadSecondVC() {
    }
    
    func loadWishList() {
        let controller = UIStoryboard(name: "Wishlist", bundle: Bundle.main).instantiateViewController(withIdentifier: "WishlistViewController") as! WishlistViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    
    func SuppliersList() {
        let controller = UIStoryboard(name: "Suppliers", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuppliersViewController") as! SuppliersListViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }



    func loadAboutUs() {
        let controller = UIStoryboard(name: "Static", bundle: Bundle.main).instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }

    
    func loadMessageVC() {
        let controller = UIStoryboard(name: "Message", bundle: Bundle.main).instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
        self.navigationController?.pushViewController(controller, animated: false)
        
    }
    
    func loadOrdersVC() {
        let controller = UIStoryboard(name: "Order", bundle: Bundle.main).instantiateViewController(withIdentifier: "OrderViewController") as! OrdersViewController
        self.navigationController?.pushViewController(controller, animated: false)
        
        
        
    }
    

}
