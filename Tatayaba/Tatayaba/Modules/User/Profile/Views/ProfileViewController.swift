//
//  ProfileViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/14/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    let profileDetailsView: ProfileDetailsView = .fromNib()
    @IBOutlet weak var scrollView: StackedScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        addSubViews()
    }

    func setupUI() {
        self.NavigationBarWithOutBackButton()
        self.addLeftBarButton()
    }

    func addSubViews() {
        scrollView.stackView.addArrangedSubview(profileDetailsView)
        profileDetailsView.translatesAutoresizingMaskIntoConstraints = false
        profileDetailsView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

}
