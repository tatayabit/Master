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
    //    case login(email: String, password: String)
    case getProfile(userId: Int)
}


extension UserEndpoint: TargetType {
    var environmentBaseURL: String {
        switch UserAPIClient.environment {
        case .production: return "https://dev2%40tatayab.com:E970ASsq0e9GmSJ2EX0BLGvskO2UF841@tatayab.com/old_store/api/"
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
        case .getProfile(let userId):
            return "users/\(userId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signUp:
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

            return .requestParameters(parameters: [ "email": user.email ?? "",
                                                    "first_name": user.firstname ?? "",
                                                    "last_name": user.lastname ?? "",
                                                    "password": user.password ?? "",
                                                    "user_type": "C",
                                                    "company_id": 1,
                                                    "status": "A"
                ], encoding: JSONEncoding.default)
        case .getProfile:
            return .requestPlain
        }
    }

    var headers: [String : String]? {

        return ["Content-type": "application/json",
                "authorization": "Basic ZGUyQHRhdGF5YWIuY29tOkU5NzBBU3NxMGU5R21TSjJFWDBCTEd2c2tPMlVGODQx=="
        ]
    }

}
