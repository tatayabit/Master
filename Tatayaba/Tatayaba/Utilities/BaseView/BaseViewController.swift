//
//  BaseViewController.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "Header")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
    }
}
