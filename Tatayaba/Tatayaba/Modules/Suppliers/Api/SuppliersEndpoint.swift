//
//  SuppliersEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum SuppliersEndpoint {
    case getSuppliers(page: String)
    case getSuppliersSortedByPosition(page: String)
    case getSupplierDetails(supplierId: String, page: String)
    case getFilteredProductOfSupplier(supplierId: String, page: String,sort_by:String,sort_order:String)
}


extension SuppliersEndpoint: TargetType {
    var environmentBaseURL: String {
        switch UserAPIClient.environment {
        case .production: return BaseUrls.production
        case .dev2: return BaseUrls.dev2
        case .staging: return BaseUrls.staging
        case .dev3: return BaseUrls.dev3
        }
    }


    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .getSuppliers, .getSuppliersSortedByPosition:
            let version = "4.0"
            return "\(version.urlEscaped)/TtmSuppliers/"
        case .getSupplierDetails(let supplierId, _):
            let version = "4.0"
            return "\(version.urlEscaped)/TtmSuppliers/\(supplierId.urlEscaped)"
        case .getFilteredProductOfSupplier( _,  _, _, _):
        let version = "4.0"
        return "\(version.urlEscaped)/TtmProducts/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getSuppliers, .getSupplierDetails, .getSuppliersSortedByPosition,.getFilteredProductOfSupplier:
            return .get
        }
    }


    var sampleData: Data {
        switch self {

        default:
            return Data()
        }
    }

    var task: Task {
        switch self {
        case .getSuppliers(let page):
            return .requestParameters(parameters: [
                                                "available_country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
                                                "items_per_page": 20,
                                                "page": page.urlEscaped,
                                                "lang_code": LanguageManager.getLanguage()
            ], encoding: URLEncoding.default)
        case .getSupplierDetails:
            var currencyId = Constants.Currency.kuwaitCurrencyId
            if let countryCurrency = CurrencySettings.shared.currentCurrency?.currencyId {
                currencyId = countryCurrency
            }
            return .requestParameters(parameters: [
                                                "available_country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
//                                                "items_per_page": 20,
//                                                "page": page.urlEscaped,
                                                "currency_id": currencyId.urlEscaped,
                                                "lang_code": LanguageManager.getLanguage()
            ], encoding: URLEncoding.default)
            
        case .getFilteredProductOfSupplier(let supplierId, let page, let sort_by, let sort_order):
            var currencyId = Constants.Currency.kuwaitCurrencyId
            if let countryCurrency = CurrencySettings.shared.currentCurrency?.currencyId {
                currencyId = countryCurrency
            }
            return .requestParameters(parameters: [ "items_per_page": 20,
                                                    "page": page.urlEscaped,
                                                    "available_country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
                                                    "lang_code": LanguageManager.getLanguage(),
                                                    "currency_id": currencyId.urlEscaped,
                                                    "sort_order": sort_order,
                                                    "sort_by": sort_by,
                                                    "supplier_id": supplierId
                ], encoding: URLEncoding.default)
        case .getSuppliersSortedByPosition(let page):
            return .requestParameters(parameters: [
                                                "available_country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
                                                "items_per_page": 20,
                                                "page": page.urlEscaped,
                                                "sort_by": "position",
                                                "sort_order": "asc"
//                                                sort_by=position&sort_order=
            ], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        var authKey = ""
        switch UserAPIClient.environment {
        case .production: authKey = Keys.Authorizations.production
        case .dev2: authKey = Keys.Authorizations.dev2
        case .staging: authKey = Keys.Authorizations.staging
        case .dev3: authKey = Keys.Authorizations.dev3
        }
        return ["Content-type": "application/json",
                "authorization": authKey//"Basic ZGUyQHRhdGF5YWIuY29tOkU5NzBBU3NxMGU5R21TSjJFWDBCTEd2c2tPMlVGODQx=="
        ]
    }

}
