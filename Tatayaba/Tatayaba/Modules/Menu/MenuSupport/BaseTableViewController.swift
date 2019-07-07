//
//  BaseTableViewController.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSliderOptions()
        self.registerForPanGestures()
    }
    
    
    func configureSliderOptions() {
        switch  sliderMenuType {
        case .leftOnly:
            self.addLeftBarButton()
            break
        case .rightOnly:
            self.addRightBarButton()
            break
        case .leftAndRight:
            self.addLeftBarButton()
            self.addRightBarButton()
            break
        }
    }
    
    func addLeftBarButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 19, height: 11))
        button.setBackgroundImage(UIImage(named: leftMenuImage), for: .normal)
        button.addTarget(self, action: #selector(self.leftMenuButtonAction(sender:)), for: .touchUpInside)
        
        let barbutton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barbutton
    }
    
    func addRightBarButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 19, height: 13))
        button.setBackgroundImage(UIImage(named: rightMenuImage), for: .normal)
        button.addTarget(self, action: #selector(self.rightMenuButtonAction(sender:)), for: .touchUpInside)
        
        let barbutton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barbutton
    }
    
    /// registers for pan gesture recognition to toggle the slide menu
    func registerForPanGestures() {
        let leftPan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handlePan(sender:)))
        leftPan.edges = .left
        self.view.addGestureRecognizer(leftPan)
        
        let rightPan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handlePan(sender:)))
        rightPan.edges = .right
        self.view.addGestureRecognizer(rightPan)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

extension BaseTableViewController {
    
    @objc func leftMenuButtonAction (sender: UIButton) {
        ContainerViewController.sharedInstance.toggleLeftSlider()
    }
    
    @objc func rightMenuButtonAction (sender: UIButton) {
        ContainerViewController.sharedInstance.toggleRightSlider()
    }
    
    @objc func handlePan(sender: UIScreenEdgePanGestureRecognizer) {
        ContainerViewController.sharedInstance.handlePanGesture(recognizer: sender)
    }
}
