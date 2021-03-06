//
//  ConciergeViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ConciergeViewController: BaseViewController, ConciergeSubViewDelegate, ImagePickerDelegate, CountryViewDelegate {
   
    @IBOutlet weak var scrollView: StackedScrollView!
    
    let conciergeSubView: ConciergeSubView = .fromNib()
    private lazy var imagePicker = ImagePicker()
    let viewModel = ConciergeViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addconciergeSubView()
        imagePicker.delegate = self
        if let country = CountrySettings.shared.currentCountry {
            conciergeSubView.countryButton.setTitle(country.name, for: .normal)
            conciergeSubView.country = country
        }
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
    func callUplaodConcierge() {
        self.showAlert()
    }
    
    func didFailConciergeValidation(errorTitle: String, errorMessage: String) {
        self.showErrorAlerr(title: errorTitle, message: errorMessage, handler: nil)
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "TATAYAB", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        if sourceType == UIImagePickerController.SourceType.camera {
            imagePicker.cameraAsscessRequest()
            
        } else if sourceType == UIImagePickerController.SourceType.photoLibrary{
            imagePicker.photoGalleryAsscessRequest()
        }
    }
    
    func countrySelected(selectedCountry: Country) {
        conciergeSubView.countryButton.setTitle(selectedCountry.name, for: .normal)
        conciergeSubView.country = selectedCountry
    }
    
    func didSelectCounty() {
        let controller = UIStoryboard(name: "Country", bundle: Bundle.main).instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    
    func didSelectSubmitConcierge(concierge: Concierge) {
        
        showLoadingIndicator(to: self.view)
        viewModel.uploadConcierge(concierge: concierge) { result in
            self.hideLoadingIndicator(from: self.view)
            switch result {
            case .success(let ConciergeResult):
                print(ConciergeResult!)
                if let ConciergeResult = ConciergeResult {
                    if ConciergeResult["status"] == "success" {
                        self.showErrorAlerr(title: Constants.Concierge.uploaded, message: "Thanks for using concierge feature,\nWe will call you back withing 48 hours!".localized(), handler: { action in
                            })
                    } else{
                        self.showConciergeUploadError()
                    }
                } else {
                    self.showConciergeUploadError()
                }
                
            case .failure(let error):
                print("the error \(error)")
                self.showConciergeUploadError()
            }
        }
    }
    
    // MARK:- show Concierge Upload Error
    private func showConciergeUploadError() {
        self.showErrorAlerr(title: Constants.Common.error, message: "Something went wrong while submitting your concierge!".localized(), handler: nil)
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
