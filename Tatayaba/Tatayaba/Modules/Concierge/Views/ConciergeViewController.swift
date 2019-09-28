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
    let viewModel = ConciergeViewModel()



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        addconciergeSubView()
        imagePicker.delegate = self
        self.NavigationBarWithOutBackButton()

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
    func didSelectCounty()
    {
        let controller = UIStoryboard(name: "Country", bundle: Bundle.main).instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController
        self.navigationController?.pushViewController(controller, animated: false)
        
    }
    

    func didSelectSubmitConcierge(concierge: Concierge) {

        showLoadingIndicator(to: self.view)
        viewModel.uploadConcierge(concierge: concierge) { result in
            self.hideLoadingIndicator(from: self.view)
            switch result {
            case .success(let ConciergeResult):
                print(ConciergeResult!)
                self.showErrorAlerr(title: "Uploaded".localized(), message: "Thanks for using concierge feature,\nWe will call you back withing 48 hours!".localized(), handler: { action in

                })

            case .failure(let error):
                print("the error \(error)")
                self.showErrorAlerr(title: "Error".localized(), message: "Something went wrong while submitting your concierge!".localized(), handler: nil)
            }
        }
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
