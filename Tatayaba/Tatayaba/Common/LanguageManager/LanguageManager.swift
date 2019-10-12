//
//  LanguageManager.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/16/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation
import MOLH

let kEnglishLanguage = "en"
let kArabicLanguage = "ar"

class LanguageManager {
    class func getLanguage() -> String {
        return MOLHLanguage.currentAppleLanguage()
    }

    class func isArabicLanguage() -> Bool {
        let currentLanguage = getLanguage()
        return currentLanguage == kArabicLanguage
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
