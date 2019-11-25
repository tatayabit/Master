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

        print("before comporess --> image height: \(self.size.height)")
        print("before comporess --> image Width: \(self.size.width)")
            
        let imgData = self.jpegData(compressionQuality: 1.0)
        print("Size of Image: \(String(describing: imgData?.count)) bytes")

        let resizedImage = self.resized(toWidth: 300)!

        guard let compressData = resizedImage.jpegData(compressionQuality: 1.5) else { return "" } //max value is 1.0 and minimum is 0.0

        print("Size of Compress Data Image: \(String(describing: compressData.count)) bytes")

        guard let compressedImage = UIImage(data: compressData) else { return "" }
        
        guard let imageData = compressedImage.pngData() else { return "" }
        print("after comporess --> image height: \(compressedImage.size.height)")
        print("after comporess --> image Width: \(compressedImage.size.width)")
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
