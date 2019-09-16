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
let kArabicLanguage = "en"

class LanguageManager {
    static let DEFAULT_LANGUAGE = "defLanguageVal"

    class func setLanguage(_ lang: String) {
        UserDefaults.standard.set(lang, forKey: DEFAULT_LANGUAGE)
    }

    class func getLanguage() -> String {
        let currentLanguage = UserDefaults.standard.string(forKey: DEFAULT_LANGUAGE)
        if currentLanguage == nil {
            setLanguage(kEnglishLanguage)
            MOLH.setLanguageTo(kEnglishLanguage)
        }
        return currentLanguage ?? kEnglishLanguage
    }

    class func isArabicLanguage() -> Bool {
        let currentLanguage = getLanguage()
        return currentLanguage == kArabicLanguage
    }


    class func value(for key: String) -> String {
        if isArabicLanguage() {
            return Bundle.main.localizedString(forKey: key, value: "", table: "ArabicStrings")
        } else {
            return Bundle.main.localizedString(forKey: key, value: "", table: "EnglishStrings")
        }
    }
}
