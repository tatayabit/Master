//
//  ProductsEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/7/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum ProductsEndpoint {
    case getProducts
    case getAllCategories
    case getProductsOfCategory(categoryId: String, page: String)
    case getProductFeatures
    case getProductDetails(productId: String)
    case getAlsoBoughtProducts(productId: String)
    case search(keyword: String, page: String)
}


extension ProductsEndpoint: TargetType {
    var environmentBaseURL: String {
        switch UserAPIClient.environment {
        case .production: return "http://ios_tt%40tatayab.com:21Ju1619GAbm2u1pu0TP4hjyccAL07WP@dev.tatayab.com/api/"
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
        case .getProducts:
            return "products"
        case .getAllCategories:
            let version = "4.0"
            return "\(version.urlEscaped)/TtmCategories"
        case .getProductsOfCategory:
            let version = "4.0"
            return "\(version.urlEscaped)/TtmProducts"
        case .getProductFeatures:
            return "TtmCategories/268/products"
        case .getProductDetails(let productId):
            let version = "4.0"
            return "\(version.urlEscaped)/TtmProducts/\(productId.urlEscaped)"
        case .getAlsoBoughtProducts:
            let version = "4.0"
            return "\(version.urlEscaped)/TtmBlocks/77"
        case .search:
            let version = "4.0"
            return "\(version.urlEscaped)/TtmProducts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProducts, .getAllCategories, .getProductsOfCategory, .getProductFeatures, .getProductDetails, .getAlsoBoughtProducts, .search:
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
        case .getProducts:
            return .requestPlain
            
        case .getProductDetails:
            var currencyId = Constants.Currency.kuwaitCurrencyId

            if let countryCurrency = CurrencySettings.shared.currentCurrency?.currencyId {
                currencyId = countryCurrency
            }
            return .requestParameters(parameters: ["currency_id": currencyId.urlEscaped,
                                                   "lang_code": LanguageManager.getLanguage()
            ], encoding: URLEncoding.default)
            
        case .getAllCategories:
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
            
        case .getProductsOfCategory(let category, let page):
            var currencyId = Constants.Currency.kuwaitCurrencyId
            if let countryCurrency = CurrencySettings.shared.currentCurrency?.currencyId {
                currencyId = countryCurrency
            }
            return .requestParameters(parameters: [ "items_per_page": 20,
                                                    "status": "A",
                                                    "cid": category,
                                                    "page": page.urlEscaped,
                                                    "available_country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
                                                    "lang_code": LanguageManager.getLanguage(),
                                                    "currency_id": currencyId.urlEscaped
                ], encoding: URLEncoding.default)
            
        case .getProductFeatures:
            return .requestParameters(parameters: [ "items_per_page": 10
                ], encoding: URLEncoding.default)
        case .getAlsoBoughtProducts(let productId):
            var currencyId = Constants.Currency.kuwaitCurrencyId
            if let countryCurrency = CurrencySettings.shared.currentCurrency?.currencyId {
                currencyId = countryCurrency
            }
            return .requestParameters(parameters: [ "also_bought_for_product_id": productId,
                                                    "currency_id": currencyId.urlEscaped,
                                                    "lang_code": LanguageManager.getLanguage()
            ], encoding: URLEncoding.default)
            
        case .search(let keyword, let page):
        var currencyId = Constants.Currency.kuwaitCurrencyId
        if let countryCurrency = CurrencySettings.shared.currentCurrency?.currencyId {
            currencyId = countryCurrency
        }
        return .requestParameters(parameters: [ "items_per_page": 20,
                                                "status": "A",
//                                                "cid": category,
                                                "page": page.urlEscaped,
                                                "available_country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
                                                "lang_code": LanguageManager.getLanguage(),
                                                "currency_id": currencyId.urlEscaped,
                                                "search": "Y",
                                                "q": keyword
            ], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        
        return ["Content-type": "application/json",
                "authorization": "Basic ZGUyQHRhdGF5YWIuY29tOkU5NzBBU3NxMGU5R21TSjJFWDBCTEd2c2tPMlVGODQx=="
        ]
    }
    
}
