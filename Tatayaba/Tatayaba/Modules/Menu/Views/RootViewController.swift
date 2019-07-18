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
    
    
    /// Determines selected menu and navigates to selected screen
    ///
    /// - Parameter item: selected menu item
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
        case "ORDERS":
            self.loadOrdersVC()
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
    
    func loadOrdersVC() {
        
        let controller = UIStoryboard(name: "Cart", bundle: Bundle.main).instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(controller, animated: false)
       
    }

    func loadWishList() {
        let controller = UIStoryboard(name: "Wishlist", bundle: Bundle.main).instantiateViewController(withIdentifier: "WishlistViewController") as! WishlistViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }
<<<<<<< HEAD

    func loadAboutUs() {
        let controller = UIStoryboard(name: "Static", bundle: Bundle.main).instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }
=======
    
    func loadMessageVC() {
        let controller = UIStoryboard(name: "Message", bundle: Bundle.main).instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
        self.navigationController?.pushViewController(controller, animated: false)
        
        
        
    }
    
>>>>>>> FT_Messages15072019
}
