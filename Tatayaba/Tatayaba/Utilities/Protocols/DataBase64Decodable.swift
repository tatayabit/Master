//
//  DataBase64Decodable.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 11/6/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

protocol DataBase64Decodable {
    func base64Decoded(encodedString: String) -> String
    func json(from jsonString: String ) -> [String: Any]
}
extension DataBase64Decodable {
    func base64Decoded(encodedString: String) -> String {
        guard let data = Data(base64Encoded: encodedString) else { return "" }
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    func json(from jsonString: String ) -> [String: Any] {
        var resultJson = [String: Any]()
        let data = Data(jsonString.utf8)
         do {
            resultJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
            } catch let error {
                print(error)
            }
        return resultJson
    }
}
