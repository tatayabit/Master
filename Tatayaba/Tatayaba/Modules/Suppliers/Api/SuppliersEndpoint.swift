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
}


extension SuppliersEndpoint: TargetType {
    var environmentBaseURL: String {
        switch UserAPIClient.environment {
        case .production: return "https://ttm@tatayab.com:608Wg8D72001FDUFT70F69nbw53KWmR1@tatayab.com/api/"
        case .qa: return "http://localhost:3000/"
        case .staging: return "http://localhost:3000/"
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
        }
    }

    var method: Moya.Method {
        switch self {
        case .getSuppliers, .getSupplierDetails, .getSuppliersSortedByPosition:
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
        return ["Content-type": "application/json",
                "authorization": "ZGV2X2lvc0B0YXRheWFiLmNvbTo2MzM3TTQxQjMwYWY0U2g3QTYwMDZsU3EyamFiZjNNMg=="//"Basic ZGV2MkB0YXRheWFiLmNvbTo4OUlPMzlOM1pKTVRKSTcweUdGOVBqQjk5RDhVNTcyOQ=="
        ]
    }

}
