//
//  MessagesViewController.swift
//  Tatayaba
//
//  Created by Admin on 15/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class MessagesViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var messageTable_view: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        self.NavigationBarWithOutBackButton()
        self.addLeftBarButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension MessagesViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MessageTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MessageTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
