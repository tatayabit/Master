//
//  ConciergeViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ConciergeViewController: BaseViewController, ConciergeSubViewDelegate, ImagePickerDelegate {

    @IBOutlet weak var scrollView: StackedScrollView!

    let conciergeSubView: ConciergeSubView = .fromNib()
    private lazy var imagePicker = ImagePicker()



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        addconciergeSubView()
        imagePicker.delegate = self

    }

    fileprivate func addconciergeSubView() {
        scrollView.stackView.addArrangedSubview(conciergeSubView)
        conciergeSubView.translatesAutoresizingMaskIntoConstraints = false
        conciergeSubView.heightAnchor.constraint(equalToConstant: 750).isActive = true
        conciergeSubView.delegate = self
    }

    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.present(parent: self, sourceType: sourceType)
    }

    // MARK:- ConciergeSubViewDelegate
    func didSelectUplaodConcierge() {
        imagePicker.photoGalleryAsscessRequest()
    }

    // MARK:- ImagePickerDelegate
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        conciergeSubView.bannerImageView.image = image
        imagePicker.dismiss()
    }

    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) { imagePicker.dismiss() }

    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed { presentImagePicker(sourceType: .photoLibrary) }
    }

    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        // works only on real device (crash on simulator)
        if accessIsAllowed { presentImagePicker(sourceType: .camera) }
    }
}
