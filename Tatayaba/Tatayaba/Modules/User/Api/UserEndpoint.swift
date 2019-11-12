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
    case updateProfile(user: User)
    case login(user: User)
    case forgetPassword(email: String)
    case getProfile(userId: Int)
    
}


extension UserEndpoint: TargetType {
    var environmentBaseURL: String {
        switch UserAPIClient.environment {
        case .production: return "http://dev_ios%40tatayab.com:6337M41B30af4Sh7A6006lSq2jabf3M2@dev2.tatayab.com/api/"
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
        case .signUp:
            return "users"
        case .gusetSignUp:
            return "users"
        case .updateProfile:
            return "4.0/TtmUsers"
        case .getProfile(let userId):
            let version = "4.0"
            return "\(version.urlEscaped)/TtmUsers/\(userId)"
        case .login:
            return "4.0/TtmAuth"
        case .forgetPassword:
            return "40/TtmForgetPass"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp,.gusetSignUp, .login, .updateProfile:
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
                                                    "status": "A"
                ], encoding: JSONEncoding.default)
        case .updateProfile(let user):
            return .requestParameters(parameters: [ "update": "Y",
                                                    "user_id" : user.identifier,
                                                    "firstname": user.firstname,
                                                    "b_firstname": user.firstname,
                                                    "b_address": user.billingAddress,
                                                    "b_city": user.billingCity,
                                                    "b_county": user.billingCountry,
                                                    "b_state": user.state,
                                                    "b_country": user.billingCountry,
                                                    "b_zipcode": user.zipCode,
                                                    "b_phone": user.billingPhone
                ], encoding: JSONEncoding.default)
        case .getProfile:
            return .requestPlain
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
        return ["Content-type": "application/json",
                "authorization": "Basic ZGUyQHRhdGF5YWIuY29tOkU5NzBBU3NxMGU5R21TSjJFWDBCTEd2c2tPMlVGODQx=="
        ]
    }
    
}
