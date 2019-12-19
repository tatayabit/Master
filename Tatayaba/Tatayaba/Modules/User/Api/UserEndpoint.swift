//
//  UserEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/3/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum UserEndpoint {
    case signUp(user: User)
    case gusetSignUp(user: User)
    case login(user: User)
    case forgetPassword(email: String)
    case updateProfile(user: User)
    case getProfile(userId: String)
    
}


extension UserEndpoint: TargetType {
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
        case .signUp:
            return "users"
        case .gusetSignUp:
            return "users"
        case .updateProfile:
            return "4.0/TtmUsers"
        case .getProfile(let userId):
            return "4.0/TtmUsers/\(userId.urlEscaped)"
        case .login:
            return "4.0/TtmAuth"
        case .forgetPassword:
            return "40/TtmForgetPass"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp, .gusetSignUp, .login, .updateProfile:
            return .post
        case .getProfile, .forgetPassword:
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
        case .signUp(let user):
        
            return .requestParameters(parameters: [ "email": user.email ,
                                                    "firstname": user.firstname ,
                                                    "password": user.password ,
                                                    "user_type": "C",
                                                    "company_id": 1,
                                                    "status": "A"
                ], encoding: JSONEncoding.default)
        case .gusetSignUp(let user):
            
            return .requestParameters(parameters: [ "email": user.email ,
                                                    "firstname": user.firstname ,
                                                    "password": user.password ,
                                                    "user_type": "C",
                                                    "company_id": 1,
                                                    "status": "A",
                                                    "b_firstname": user.firstname,
                                                    "b_address": user.billingAddress,
                                                    "b_city": user.billingCity,
                                                    "b_county": CountrySettings.shared.currentCountry?.code ?? "kw",
                                                    "b_state": user.state,
                                                    "b_country": CountrySettings.shared.currentCountry?.code ?? "kw",
                                                    "b_zipcode": user.zipCode,
                                                    "b_phone": user.billingPhone
                ], encoding: JSONEncoding.default)
        case .updateProfile(let user):
            return .requestParameters(parameters: [ "update": "Y",
                                                    "user_id" : user.identifier,
                                                    "firstname": user.firstname,
                                                    "b_firstname": user.firstname,
                                                    "b_address": user.billingAddress,
                                                    "b_city": user.billingCity,
                                                    "b_county": CountrySettings.shared.currentCountry?.code ?? "kw",
                                                    "b_state": user.state,
                                                    "b_country": CountrySettings.shared.currentCountry?.code ?? "kw",
                                                    "b_zipcode": user.zipCode,
                                                    "b_phone": user.billingPhone,
                                                    "fields": [ "40": user.block]
                ], encoding: JSONEncoding.default)
        case .getProfile(let userId):
            return .requestPlain//.requestParameters(parameters: [ "id": userId.urlEscaped
//            ], encoding: URLEncoding.queryString)
        case .forgetPassword(let email):
            return .requestParameters(parameters: [ "email": email
            ], encoding: URLEncoding.queryString)
        case .login(let user):
            return .requestParameters(parameters: [ "email": user.email ,
                                                    "password": user.password
                ], encoding: JSONEncoding.default)
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
