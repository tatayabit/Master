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
    

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var cart_Tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        EditButton = "0"
        setupUI()
        
        
       
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    func setupUI() {
        self.NavigationBarWithOutBackButton()
        self.addLeftBarButton()
        Add_EDitUI()

  
       
        self.collectionView.register(RecommendedCollectionViewCell.nib, forCellWithReuseIdentifier: RecommendedCollectionViewCell.identifier)
 
    }
    
    func Add_EDitUI(){
        
        EditBtn.setImage(UIImage(named: "Edit"), for: [])
        EditBtn.addTarget(self, action: #selector(Edit_Button_Action), for: UIControlEvents.touchUpInside)
        EditBtn.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let EditButton = UIBarButtonItem(customView: EditBtn)
        self.navigationItem.rightBarButtonItem  = EditButton
        
        
       
        
    }

    
    
    @objc func Edit_Button_Action() {
        
        EditButton = "1"
     
        EditBtn.isHidden = true
        EditOkBtn.setImage(UIImage(named: "tick"), for: [])
        EditOkBtn.addTarget(self, action: #selector(EditOK_Button_Action), for: UIControlEvents.touchUpInside)
        EditOkBtn.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let OkButton = UIBarButtonItem(customView: EditOkBtn)
        self.navigationItem.rightBarButtonItem  = OkButton
        EditOkBtn.isHidden = false
        
        
        
        cart_Tableview.reloadData()
        
    }
    @objc func EditOK_Button_Action() {
        
        EditButton = "0"
        EditBtn.isHidden = false
        EditOkBtn.isHidden = true
        Add_EDitUI()
        cart_Tableview.reloadData()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
 //Tableview
extension CartViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CartCellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CartTableViewCell
        
        if EditButton == "1"{
           cell.cell_Close.isHidden = false
        }else{
           cell.cell_Close.isHidden = true
            
        }
        
        
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
