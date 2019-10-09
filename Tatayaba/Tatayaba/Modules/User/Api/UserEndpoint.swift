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
    case getProfile(userId: Int)
    
}


extension UserEndpoint: TargetType {
    var environmentBaseURL: String {
        switch UserAPIClient.environment {
        case .production: return "http://dev2%40tatayab.com:gsh34ps0N2DX5qS3y0P09U220h15HM8T@dev2.tatayab.com/api/"
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
        case .getProfile(let userId):
            let version = "4.0"
            return "\(version.urlEscaped)/TtmUsers/\(userId)"
        case .login:
            return "4.0/TtmAuth"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp,.gusetSignUp, .login:
            return .post
        case .getProfile:
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
                                                    "first_name": user.firstname ,
                                                    "password": user.password ,
                                                    "user_type": "C",
                                                    "company_id": 1,
                                                    "status": "A"
                ], encoding: JSONEncoding.default)
        case .gusetSignUp(let user):
            
            return .requestParameters(parameters: [ "email": user.email ,
                                                    "first_name": user.firstname ,
                                                    "password": user.password ,
                                                    "user_type": "C",
                                                    "company_id": 1,
                                                    "status": "A"
                ], encoding: JSONEncoding.default)
        case .getProfile:
            return .requestPlain
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
