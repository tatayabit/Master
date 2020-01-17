//
//  FilterEndpoint.swift
//  Tatayaba
//
//  Created by new on 1/14/20.
//  Copyright © 2020 Shaik. All rights reserved.
//

//
//  SuppliersEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum FilterEndpoint {
    case getFilteredProduct(parameters: [String: Any])
    case getSuppliers
    case getCategories
}


extension FilterEndpoint: TargetType {
    
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
        case .getFilteredProduct( _):
            let version = "4.0"
            return "\(version.urlEscaped)/TtmProducts/"
        case .getSuppliers:
            let version = "4.0"
            return "\(version.urlEscaped)/TtmSuppliers/"
        case .getCategories:
            let version = "4.0"
            return "\(version.urlEscaped)/TtmCategoriesTree/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getFilteredProduct,.getSuppliers,.getCategories:
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
            
        case .getFilteredProduct(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getSuppliers:
            return .requestParameters(parameters: [
                    "available_country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
                                            "lang_code": LanguageManager.getLanguage(),
                                            "get_all":""
            ], encoding: URLEncoding.default)
        case .getCategories:
            var currencyId = Constants.Currency.kuwaitCurrencyId
            if let countryCurrency = CurrencySettings.shared.currentCurrency?.currencyId {
                currencyId = countryCurrency
            }
            return .requestParameters(parameters: [ "items_per_page": 0,
                                                    "status": "A",
                                                    "available_country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
                                                    "lang_code": LanguageManager.getLanguage(),
                                                    "currency_id": currencyId.urlEscaped
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
