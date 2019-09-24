//
//  BaseViewController.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import MBProgressHUD

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
        let action = UIAlertAction(title: "OK".localized(), style: .cancel, handler: handler)
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
    

}

extension UIViewController {
    
    func pushToNextViewController (storyboardName : String?,segueName: String?)
    {
        let viewController: UIViewController? = UIStoryboard(name:storyboardName!, bundle: nil).instantiateViewController(withIdentifier: segueName!)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
  
       
    
        
    }
    
    func NavigationBarWithOutBackButton(){
       
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.hidesBottomBarWhenPushed = false
        self.tabBarController?.tabBar.isHidden = false
      //  let navBackgroundImage:UIImage! = UIImage(named:" ")
        setupNavBarLogo()
//    self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "Header")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
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
}
