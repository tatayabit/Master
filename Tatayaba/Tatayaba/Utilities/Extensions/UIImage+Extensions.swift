//
//  UIImage+Extensions.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/24/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

extension UIImage {
    func toBase64() -> String {
        guard let compressData = self.jpegData(compressionQuality: 0.5) else { return "" } //max value is 1.0 and minimum is 0.0
        guard let compressedImage = UIImage(data: compressData) else { return "" }
        
        guard let imageData = compressedImage.pngData() else { return "" }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
