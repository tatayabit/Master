//
//  BaseViewController.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import MBProgressHUD
import MOLH

extension Constants {
    struct Common {
        static let ok = "OK".localized()
        static let error = "Error".localized()
        static let success = "Success".localized()
    }
}

class BaseViewController: UIViewController {
    var loadingArr = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK:- Error Alert
    func showErrorAlerr(title: String?, message: String?, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let htmlData = NSString(string: message ?? "").data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
            NSAttributedString.DocumentType.html]
        let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                              options: options,
                                                              documentAttributes: nil)
        alert.setValue(attributedString, forKey: "attributedMessage")
        alert.view.traverseRadius(4)
        alert.view.backgroundColor = .white
        let action = UIAlertAction(title: Constants.Common.ok, style: .cancel, handler: handler)
        action.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(action)

        self.present(alert, animated: true) {
            print("completion block alert")
        }
    }
    
    // MARK:- MBProgressHUD
    func showLoadingIndicator(to containerView: UIView) {
        MBProgressHUD.showAdded(to: containerView, animated: true)
        loadingArr.append(containerView)
    }

    func hideLoadingIndicator(from containerView: UIView) {
        MBProgressHUD.hide(for: containerView, animated: true)
        if loadingArr.contains(containerView) {
            loadingArr.removeAll(where: { $0 == containerView })
        }
    }
    
    func addSearchBtn(){
        let searchBtn = UIButton(type: .custom)
        searchBtn.setImage(UIImage(named: "Search"), for: .normal)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        searchBtn.addTarget(self, action: #selector(HomeViewController.search), for: .touchUpInside)
        let searchItem = UIBarButtonItem(customView: searchBtn)
        self.navigationItem.rightBarButtonItem  = searchItem
    }
    

}

extension UIViewController {
    
    func pushToNextViewController (storyboardName : String?,segueName: String?)
    {
        let viewController: UIViewController? = UIStoryboard(name:storyboardName!, bundle: nil).instantiateViewController(withIdentifier: segueName!)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }

    func navigateToHome() {
        // to solve problem of navigation bar and badge showing
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
    }
    
    func NavigationBarWithOutBackButton(){
       
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barTintColor = .brandDarkBlue//UIColor(red: 34.0/255, green: 28.0/255, blue: 53.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.hidesBottomBarWhenPushed = false
        self.tabBarController?.tabBar.isHidden = false
        var logo: UIImage = UIImage()
        if MOLHLanguage.currentAppleLanguage() == "en" {
            logo = UIImage(named: "barName_Eng") ?? UIImage()
        } else {
            logo = UIImage(named: "barName_ar") ?? UIImage()
        }
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
//        let searchBtn = UIButton(type: .custom)
//        searchBtn.setImage(UIImage(named: "Search"), for: .normal)
//        searchBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        searchBtn.addTarget(self, action: #selector(HomeViewController.search), for: .touchUpInside)
//        let searchItem = UIBarButtonItem(customView: searchBtn)
//        self.navigationItem.rightBarButtonItem  = searchItem

    }
    
    
    func NavigationBarWithBackButton(){
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barTintColor = .brandDarkBlue//UIColor(red: 34.0/255, green: 28.0/255, blue: 53.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.hidesBottomBarWhenPushed = false
        self.tabBarController?.tabBar.isHidden = false
        var logo: UIImage = UIImage()
        if MOLHLanguage.currentAppleLanguage() == "en" {
            logo = UIImage(named: "barName_Eng") ?? UIImage()
        } else {
            logo = UIImage(named: "barName_ar") ?? UIImage()
        }
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "BackBar"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(action), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.leftBarButtonItem  = item2
        
        
        
    }
    @objc func action(){
        navigationController?.popViewController(animated: true)
    }
    
    
    
}


extension UIViewController {
    func setupNavigationBar(image: UIImage) {
        //set your image navigation bar center
        //set titile
        //self.navigationItem.title =  title
        //set image in the center
        self.navigationItem.titleView = UIImageView(image: image)
    }

    func setupNavBarLogo() {
        self.setupNavigationBar(image:UIImage(named: "log_nav")!)
    }
    
    func setButton(button: UIButton, hidden: Bool) {
        UIView.transition(with: button, duration: 0.5, options: .transitionCrossDissolve, animations: {
            button.isHidden = hidden
        })
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
}

extension UIView {
    func traverseRadius(_ radius: Float) {
        layer.cornerRadius = CGFloat(radius)
        
        for subview: UIView in subviews {
            subview.traverseRadius(radius)
        }
    }
}
