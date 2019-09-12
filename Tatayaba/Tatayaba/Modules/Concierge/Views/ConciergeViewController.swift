//
//  ConciergeViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ConciergeViewController: BaseViewController, ConciergeSubViewDelegate {

    @IBOutlet weak var scrollView: StackedScrollView!

    let conciergeSubView: ConciergeSubView = .fromNib()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        addconciergeSubView()
    }

    fileprivate func addconciergeSubView() {
        scrollView.stackView.addArrangedSubview(conciergeSubView)
        conciergeSubView.translatesAutoresizingMaskIntoConstraints = false
        conciergeSubView.heightAnchor.constraint(equalToConstant: 750).isActive = true
    }

    // MARK:- ConciergeSubViewDelegate
    func didSelectUplaodConcierge() {
        
    }
}
