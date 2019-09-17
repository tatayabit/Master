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
//    static let DEFAULT_LANGUAGE = "defLanguageVal"

//    class func setLanguage(_ lang: String) {
//        UserDefaults.standard.set(lang, forKey: DEFAULT_LANGUAGE)
//    }

    class func getLanguage() -> String {
//        let currentLanguage = UserDefaults.standard.string(forKey: DEFAULT_LANGUAGE)
//        if currentLanguage == nil {
//            setLanguage(kEnglishLanguage)
//            MOLH.setLanguageTo(kEnglishLanguage)
//        }

        return MOLHLanguage.currentAppleLanguage()
    }

    class func isArabicLanguage() -> Bool {
        let currentLanguage = getLanguage()
        return currentLanguage == kArabicLanguage
    }


//    class func value(for key: String) -> String {
//        if isArabicLanguage() {
//            return Bundle.main.localizedString(forKey: key, value: "", table: "ArabicStrings")
//        } else {
//            return Bundle.main.localizedString(forKey: key, value: "", table: "EnglishStrings")
//        }
//    }
}

extension String {

    func localized() -> String {

        if LanguageManager.isArabicLanguage() {
            print("arabiC: key--> \(self) --- Value: \(NSLocalizedString(self, tableName: "ArabicStrings", bundle: .main, value: "", comment: ""))")
            return NSLocalizedString(self, tableName: "ArabicStrings", bundle: .main, value: "", comment: "")
        }
        return NSLocalizedString(self, tableName: "EnglishStrings", bundle: .main, value: "", comment: "")
    }
}
