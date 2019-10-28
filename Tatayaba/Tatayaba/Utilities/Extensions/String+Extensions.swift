//
//  String+Extensions.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/9/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var formattedPrice: String {
        let priceFloat = Float(self)
        return String(format: "%.3f KD", priceFloat ?? "0.000 KD")
    }
    
    func stripOutHtml() -> String {
        do {
            guard let data = self.data(using: .unicode) else {
                return ""
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return ""
        }
    }
}


extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
