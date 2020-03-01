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
    case getFilteredProductOfCategory(categoryId: String, page: String,sort_by:String,sort_order:String)
}


extension ProductsEndpoint: TargetType {
    var environmentBaseURL: String {
        switch ProductsAPIClient.environment {
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
        case .getProducts:
            return "products"
        case .getAllCategories:
            let version = "4.0"
            return "\(version.urlEscaped)/TtmCategories"
        case .getProductsOfCategory:
            let version = "4.0"
            return "\(version.urlEscaped)/TtmProducts"
        case .getFilteredProductOfCategory( _,  _, _, _):
            let version = "4.0"
            return "\(version.urlEscaped)/TtmProducts/"
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
        case .getProducts, .getAllCategories, .getProductsOfCategory, .getProductFeatures, .getProductDetails, .getAlsoBoughtProducts, .search, .getFilteredProductOfCategory:
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
            print(LanguageManager.getLanguage())
            return .requestParameters(parameters: ["currency_id": currencyId.urlEscaped,
                                                   "country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
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
                                                    "country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
                                                    "lang_code": LanguageManager.getLanguage(),
                                                    "currency_id": currencyId.urlEscaped
                ], encoding: URLEncoding.default)
            
        case .getFilteredProductOfCategory(let category, let page, let sort_by, let sort_order):
        var currencyId = Constants.Currency.kuwaitCurrencyId
        if let countryCurrency = CurrencySettings.shared.currentCurrency?.currencyId {
            currencyId = countryCurrency
        }
        return .requestParameters(parameters: [ "items_per_page": 20,
                                                "status": "A",
                                                "cid": category,
                                                "page": page.urlEscaped,
                                                "available_country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
                                                "country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
                                                "lang_code": LanguageManager.getLanguage(),
                                                "currency_id": currencyId.urlEscaped,
                                                "sort_order": sort_order,
                                                "sort_by": sort_by
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
                                                    "country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
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
                                                "country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
                                                "lang_code": LanguageManager.getLanguage(),
                                                "currency_id": currencyId.urlEscaped,
                                                "search": "Y",
                                                "q": keyword
            ], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        var authKey = ""
        switch ProductsAPIClient.environment {
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
