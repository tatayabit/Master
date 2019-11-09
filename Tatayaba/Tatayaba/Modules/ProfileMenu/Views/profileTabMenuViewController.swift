//
//  profileTabMenuViewController.swift
//  Tatayaba
//
//  Created by Maheep on 16/09/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import MOLH

extension Constants {
    struct Profile {
        static let brands = "BRANDS".localized()
        static let wishlist = "Wish List".localized()
        static let myOrders = "My Orders".localized()
        static let changeLanguage = "Change Language".localized()
        static let currencies = "Currencies".localized()
        static let changeCountry = "Change Country".localized()
        static let privacyPolicy = "Privacy Policy".localized()
        static let logout = "Logout".localized()
        static let deliveryAndReturnPolicy = "Delivery and Return Policy".localized()
        static let liveChat = "Live Chat".localized()
        static let notifications = "Notifications".localized()
        static let welcome = "Welcome".localized()
        static let login = "LOG IN".localized()
    }
}

class profileTabMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CountryViewDelegate, CurrencyViewDelegate {

    var Session1: [String] = [Constants.Profile.myOrders]
    var Session1_img: [String] = ["Cart"]

    var Session2: [String] = [Constants.Profile.changeLanguage, Constants.Profile.currencies, Constants.Profile.changeCountry, Constants.Profile.liveChat, Constants.Profile.notifications]
    var Session2_img: [String] = ["settings", "settings", "settings", "liveChat", "Notifiction"]


    var Session3: [String] = [Constants.Profile.deliveryAndReturnPolicy, Constants.Profile.privacyPolicy,Constants.Profile.logout]
    var Session4: [String] = [Constants.Profile.deliveryAndReturnPolicy, Constants.Profile.privacyPolicy]
    var Session3_img: [String] = ["delivery", "privacy","logout"]


    private let orderDetailsSegue = "order_details_segue"

    @IBOutlet weak var profileMenu_tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.NavigationBarWithOutBackButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        if Customer.shared.loggedin && Customer.shared.user?.identifier != "" {
            self.navigationItem.title = "\(Constants.Profile.welcome) \(Customer.shared.user?.firstname ?? "")"
        }
        self.profileMenu_tableView.reloadData()
    }


    @objc func sign_buttonAction() {
       self.loadFirstVC()
    }

}

extension profileTabMenuViewController{

    // MARK:- TableView Number of sections and rows
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if Customer.shared.loggedin && Customer.shared.user?.identifier != "" {
                 return Session1.count
            }
            return 1
        } else if section == 1 {
            return Session2.count
        }

        if Customer.shared.loggedin && Customer.shared.user?.identifier != "" {
            return Session3.count
        }
        return Session4.count
    }

    // MARK:- TableView Height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if Customer.shared.loggedin && Customer.shared.user?.identifier != "" {
                return 60
            }
            return 100
        }
        return 60
    }

    // MARK:- TableView DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ProfileMenuTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProfileMenuTableViewCell
        if  indexPath.section == 0 {
            if Customer.shared.loggedin && Customer.shared.user?.identifier != "" {
                cell.title_lbl.text = self.Session1[indexPath.row]
                cell.title_img.image = UIImage(named: self.Session1_img[indexPath.row])
            } else {
                cell.title_lbl.isHidden = true
                cell.title_img.isHidden = true
                cell.accessoryType = UITableViewCell.AccessoryType.none
                let sign_button = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width/2-70, y: 25, width: 150, height: 50))
                sign_button.setTitle(Constants.Profile.login, for: .normal)
                sign_button.addTarget(self, action: #selector(sign_buttonAction), for: .touchUpInside)
                sign_button.setTitleColor(UIColor.black, for: .normal)
                sign_button.layer.borderWidth = 1
                sign_button.layer.borderColor =  UIColor.black.cgColor
                sign_button.layer.cornerRadius = 15
                cell.addSubview(sign_button)
            }
        } else if  indexPath.section == 1 {
            cell.title_lbl.text = self.Session2[indexPath.row]
            cell.title_img.image = UIImage(named: self.Session2_img[indexPath.row])
        } else if  indexPath.section == 2 {

            if Customer.shared.loggedin && Customer.shared.user?.identifier != "" {
                cell.title_lbl.text = self.Session3[indexPath.row]
            } else {
                cell.title_lbl.text = self.Session4[indexPath.row]
            }
            cell.title_img.image = UIImage(named: self.Session3_img[indexPath.row])
        }
        return cell
    }

    // MARK:- TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if  indexPath.section == 0 {
       let indextitle = self.Session1[indexPath.row]
            if indextitle  == Constants.Profile.wishlist {
                self.loadWishList()
            } else if indextitle  == Constants.Profile.myOrders {
                self.loadOrdersVC()
            }

        }else if  indexPath.section == 1 {
            let indextitle = self.Session2[indexPath.row]
            if indextitle  == Constants.Profile.changeLanguage {
                //setting page
                changeLanguege()
            }
            if indextitle  == Constants.Profile.currencies {
                loadCurrenciesVC()
            }

            if indextitle == Constants.Profile.changeCountry {
                self.loadCountries()
            }
            if indextitle == Constants.Profile.liveChat {
                loadLiveChat()
            }

        }else if  indexPath.section == 2 {
            let indextitle = self.Session3[indexPath.row]
            if indextitle  == Constants.Profile.privacyPolicy {
            UserDefaults.standard.set("Privacy", forKey: "Privacy")
                self.PrivacyView()
            } else if indextitle  == Constants.Profile.deliveryAndReturnPolicy {
            UserDefaults.standard.set("Delivery", forKey: "Privacy")

                 self.PrivacyView()
            }else  if indextitle  == Constants.Profile.logout {
                Customer.shared.logout()
            self.loadFirstVC()

            }
        }


    }

    // MARK:- Change Language
    func changeLanguege() {
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        MOLH.reset()
        reloadUI()
    }

    func reloadUI() {
        AppDelegate.shared.setupGlobalAppearance()
        self.navigateToHome()
    }

    // MARK:- Actions
    func loadWishList() {
        let controller = UIStoryboard(name: "Wishlist", bundle: Bundle.main).instantiateViewController(withIdentifier: "WishlistViewController") as! WishlistViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }

    func loadOrdersVC() {
        let controller = UIStoryboard(name: "Order", bundle: Bundle.main).instantiateViewController(withIdentifier: "OrderViewController") as! OrdersViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }

    func loadCurrenciesVC() {
        let controller = UIStoryboard(name: "Country", bundle: Bundle.main).instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController
        controller.currencyDelegate = self
        controller.viewType = 1
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func loadFirstVC() {
        let controller = UIStoryboard(name: "User", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(controller, animated: false)
         self.tabBarController?.tabBar.isHidden = true
    }

    func PrivacyView() {
        let controller = UIStoryboard(name: "ProfileTab", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        self.navigationController?.pushViewController(controller, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }

    func loadBrands() {
        let controller = UIStoryboard(name: "Suppliers", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuppliersViewController") as! SuppliersListViewController
        self.navigationController?.pushViewController(controller, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }

    func loadLiveChat() {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "LiveChatViewController") as! LiveChatViewController
        self.navigationController?.pushViewController(controller, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }

    func loadCountries() {
        let controller = UIStoryboard(name: "Country", bundle: Bundle.main).instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: false)
    }

    func countrySelected(selectedCountry: Country) {
        CountrySettings.shared.currentCountry = selectedCountry
    }
    
    func currencySelected(selectedCurrency: Currency) {
        CurrencySettings.shared.currentCurrency = selectedCurrency
    }
}
