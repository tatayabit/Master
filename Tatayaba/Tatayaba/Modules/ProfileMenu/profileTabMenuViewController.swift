//
//  profileTabMenuViewController.swift
//  Tatayaba
//
//  Created by Maheep on 16/09/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import MOLH

class profileTabMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
      var Session1: [String] = ["Wish List", "My Orders"]
    var Session1_img: [String] = ["WISHLIST", "MY ORDERS"]
      var Session2: [String] = ["Change Language", "Live Chat","Notifications"]
      var Session2_img: [String] = ["Setting", "LIVE CHAT","Notifications"]
        var Session3: [String] = ["Delivery and Return Policy", "Privacy Policy","Logout"]
    var Session3_img: [String] = ["Delivery and Return Policy", "Privacy Policy","LOGOUT"]
    
    private let orderDetailsSegue = "order_details_segue"

    @IBOutlet weak var profileMenu_tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Welcome \("Shaik")"
        self.profileMenu_tableView.reloadData()
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func sign_buttonAction() {
   
       self.loadFirstVC()
    }

}

extension profileTabMenuViewController{

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            let UserID = UserDefaults.standard.value(forKey: "UserID") as! String
            if UserID == "1"{
                 return Session1.count
            }else{
                return 1
            }
        }else {
            return Session2.count
        }
     
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            let UserID = UserDefaults.standard.value(forKey: "UserID") as! String
            if UserID == "1"{
                 return 60
            }else{
                 return 100
            }
        }else {
           return 60
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ProfileMenuTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProfileMenuTableViewCell
       
        if  indexPath.section == 0 {
            let UserID = UserDefaults.standard.value(forKey: "UserID") as! String
            if UserID == "1"{
              cell.title_lbl.text = self.Session1[indexPath.row]
         cell.title_img.image = UIImage(named: self.Session1_img[indexPath.row])
            }else{
                cell.title_lbl.isHidden = true
                cell.title_img.isHidden = true
                cell.accessoryType = UITableViewCellAccessoryType.none
                let sign_button = UIButton(frame: CGRect(x: 120, y: 25, width: 150, height: 50))
                 sign_button.setTitle("Sign in", for: .normal)
      sign_button.addTarget(self, action: #selector(sign_buttonAction), for: .touchUpInside)
               sign_button.setTitleColor(UIColor.black, for: .normal)
                sign_button.layer.borderWidth = 1
                sign_button.layer.borderColor =  UIColor.black.cgColor
                sign_button.layer.cornerRadius = 15
               cell.addSubview(sign_button)
                
            }
           
        }
       else if  indexPath.section == 1 {
            cell.title_lbl.text = self.Session2[indexPath.row]
            cell.title_img.image = UIImage(named: self.Session2_img[indexPath.row])
        }
        else if  indexPath.section == 2 {
            cell.title_lbl.text = self.Session3[indexPath.row]
            cell.title_img.image = UIImage(named: self.Session3_img[indexPath.row])
        }
        return cell
}
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if  indexPath.section == 0 {
       let indextitle = self.Session1[indexPath.row]
            if indextitle  == "Wish List"{
                self.loadWishList()
            }else if indextitle  == "My Orders"{
                self.loadOrdersVC()
            }
            
        }else if  indexPath.section == 1 {
            let indextitle = self.Session2[indexPath.row]
            if indextitle  == "Change Language"{
                //setting page
                self.changeLanguege()
            }
            
        }else if  indexPath.section == 2 {
            let indextitle = self.Session3[indexPath.row]
            if indextitle  == "Delivery and Return Policy"{
                
                //Policy page
              
            }
            if indextitle  == "Logout"{
            self.loadFirstVC()
                
            }
        }
  
        
       
    }
    

    func changeLanguege() {
//        LanguageManager.setLanguage(currentLanguage)
//        L333Localizer.switchTheLanguage(lan: currentLanguage, fromrestPage: true)

        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        MOLH.reset()

        reloadUI()
//        didUpdateLanguage
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didUpdateLanguage"), object: nil)

    }

    func reloadUI() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)

        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController

        let window = UIApplication.shared.keyWindow
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
    }
    
    func loadWishList() {
        let controller = UIStoryboard(name: "Wishlist", bundle: Bundle.main).instantiateViewController(withIdentifier: "WishlistViewController") as! WishlistViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }
    func loadOrdersVC() {
        let controller = UIStoryboard(name: "Order", bundle: Bundle.main).instantiateViewController(withIdentifier: "OrderViewController") as! OrdersViewController
        self.navigationController?.pushViewController(controller, animated: false)
        
        
        
    }
    func loadFirstVC() {
        let controller = UIStoryboard(name: "User", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(controller, animated: false)
         self.tabBarController?.tabBar.isHidden = true
    }
    
  
    
}
