//
//  profileTabMenuViewController.swift
//  Tatayaba
//
//  Created by Maheep on 16/09/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import MOLH


class Profile {
    var brands = "BRANDS".localized()
    var wishlist = "Wish List".localized()
    var myOrders = "My Orders".localized()
    var changeLanguage = "Change Language".localized()
    var currencies = "Currencies".localized()
    var changeCountry = "Change Country".localized()
    var privacyPolicy = "Privacy Policy".localized()
    var logout = "Logout".localized()
    var deliveryAndReturnPolicy = "Delivery and Return Policy".localized()
    var liveChat = "Live Chat".localized()
    var notifications = "Notifications".localized()
    var welcome = "Welcome".localized()
    var login = "LOG IN".localized()
    var Hi = "Hi".localized()
}


class profileTabMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CountryViewDelegate, CurrencyViewDelegate {

    let profile: Profile = Profile()
    var Session1 = [String]()
    var Session1_img: [String] = ["Cart"]

    var Session2 = [String]()
    var Session2_img: [String] = ["language", "currency", "country", "liveChat", "Notifiction"]


    var Session3 = [String]()
    var Session4 = [String]()
    var Session3_img: [String] = ["delivery", "privacy","logout"]


    private let orderDetailsSegue = "order_details_segue"

    @IBOutlet weak var profileMenu_tableView: UITableView!
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var mailLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Session1 = [profile.myOrders]
        Session2 = [profile.changeLanguage, profile.currencies, profile.changeCountry, profile.liveChat] //, profile.notifications
        Session3 = [profile.deliveryAndReturnPolicy, profile.privacyPolicy,profile.logout]
        Session4 = [profile.deliveryAndReturnPolicy, profile.privacyPolicy]
        NotificationCenter.default.addObserver(self, selector: #selector(updateWelcomeHeader(_:)), name: Notification.Name(rawValue: "updateWelcomeHeader"), object: nil)
         NavigationBarWithOutBackButton()
        setWelcomeHeader()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        if Customer.shared.loggedin && Customer.shared.user?.identifier != "" {
            self.navigationItem.title = "\(profile.welcome) \(Customer.shared.user?.firstname ?? "")"
        }
        if CurrencySettings.shared.currentCurrency != nil {
            Session2[1] = CurrencySettings.shared.currentCurrency?.descriptionField ?? profile.currencies
        }
        if CountrySettings.shared.currentCountry != nil {
            Session2[2] = CountrySettings.shared.currentCountry?.name ?? profile.changeCountry
        }
        self.profileMenu_tableView.reloadData()
    }

    func setWelcomeHeader() {
        if Customer.shared.loggedin {
            self.welcomeView.isHidden = false
            let name  = (Customer.shared.user?.firstname ?? "") + " " + (Customer.shared.user?.lastname ?? "")
            let email  = (Customer.shared.user?.email ?? "")
            self.nameLBL.text = "\(profile.Hi)\(name)"
            self.mailLBL.text = email
            self.nameLBL.isHidden = false
            self.mailLBL.isHidden = false
        } else {
             self.welcomeView.isHidden = true
            self.nameLBL.isHidden = true
            self.mailLBL.isHidden = true
            self.nameLBL.text = ""
            self.mailLBL.text = ""
        }
    }
    
    @objc func sign_buttonAction() {
       self.loadLoginVC()
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
                cell.title_lbl.isHidden = false
                cell.title_img.isHidden = false
                cell.title_lbl.text = self.Session1[indexPath.row]
                cell.title_img.image = UIImage(named: self.Session1_img[indexPath.row])
                for button in cell.subviews  where button is UIButton {
                    button.removeFromSuperview()
                }

            } else {
                cell.title_lbl.isHidden = true
                cell.title_img.isHidden = true
                cell.accessoryType = UITableViewCell.AccessoryType.none
                let sign_button = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width/2-70, y: 25, width: 150, height: 50))
                sign_button.setTitle(profile.login, for: .normal)
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
            if indextitle  == profile.wishlist {
                self.loadWishList()
            } else if indextitle  == profile.myOrders {
                self.loadOrdersVC()
            }

        }else if  indexPath.section == 1 {
            let indextitle = self.Session2[indexPath.row]
            if indextitle  == profile.changeLanguage {
                //setting page
                changeLanguege()
            }
            if (indextitle  == profile.currencies || indextitle  == CurrencySettings.shared.currentCurrency?.descriptionField) && indexPath.row == 1 {
                loadCurrenciesVC()
            }

            if (indextitle == profile.changeCountry || indextitle  == CountrySettings.shared.currentCountry?.name) && indexPath.row == 2 {
                self.loadCountries()
            }
            if indextitle == profile.liveChat {
                loadLiveChat()
            }

        }else if  indexPath.section == 2 {
            let indextitle = self.Session3[indexPath.row]
            if indextitle  == profile.privacyPolicy {
            UserDefaults.standard.set("Privacy", forKey: "Privacy")
                self.PrivacyView()
            } else if indextitle  == profile.deliveryAndReturnPolicy {
            UserDefaults.standard.set("Delivery", forKey: "Privacy")

                 self.PrivacyView()
            }else  if indextitle  == profile.logout {
                Customer.shared.logout()
                Cart.shared.resetLocal()
                self.setWelcomeHeader()
                self.loadLoginVC()

            }
        }


    }
    
    @objc func updateWelcomeHeader(_ notification: Notification) {
        self.setWelcomeHeader()
    }

    // MARK:- Change Language
    func changeLanguege() {
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        UserDefaults.standard.set(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en", forKey: "Language")
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

    func loadLoginVC() {
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
        navigateToHome()
    }
}
