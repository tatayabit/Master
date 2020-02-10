//
//  APIClient.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/3/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum APIEnvironment {
    case staging
    case dev2
    case dev3
    case production
}

struct BaseUrls {
    static let production = "http://ttm%40tatayab.com:608Wg8D72001FDUFT70F69nbw53KWmR1@tatayab.com/api/"
    static let staging = "http://localhost:3000/"
    static let dev2 = "http://dalia.abdulmonsif1%40gmail.com:87257uWK71P0J71SKy1I238242SP6iKQ@dev2.tatayab.com/api/"
    static let dev3 = "http://m.roshan%40tatayab.com:9Z19bF0f911Se53c5EE4U4Ik4F2282Fr@dev3.tatayab.com/api/"
    
}

struct Keys {
    struct Authorizations {
        static let production = "ZGV2X2lvc0B0YXRheWFiLmNvbTo2MzM3TTQxQjMwYWY0U2g3QTYwMDZsU3EyamFiZjNNMg=="
        static let staging = "http://localhost:3000/"
        static let dev2 = "http://localhost:3000/"
        static let dev3 = "http://localhost:3000/"
    }
}

protocol APIClient {
    var provider: MoyaProvider<MultiTarget> { get }
    func fetch<T: Decodable>(with target: TargetType, completion: @escaping (APIResult<T, MoyaError>) -> Void)
}

extension APIClient {
    func fetch<T: Decodable>(with target: TargetType, completion: @escaping (APIResult<T, MoyaError>) -> Void) {
        provider.manager.session.configuration.urlCache?.removeAllCachedResponses()
        provider.request(MultiTarget(target)) { result in
            switch result {
            case .success(let response):
                do {
                    print("response: \(response)")
                    if response.statusCode >= 300 {
                        let errorMessage = try response.map(ErrorMessage.self)
                        print("errorMessage: \(errorMessage)")
                        
                        if errorMessage.message.count > 0 {
                            throw APIError.errorMessage(message: errorMessage.message)
                        } else {
                            throw APIError.requestFailed
                        }
//                        completion(APIResult.success(result))
                        
                        //completion(APIResult.failure(APIError.requestFailed))
                    } else {
                        let result = try JSONDecoder().decode(T.self, from: response.data)
                        print("result: \(result)")
                        completion(APIResult.success(result))
                    }

                } catch let err {
                    print("error: \(err)")
                    completion(APIResult.failure(MoyaError.objectMapping(err, response)))
                }
                break

            case .failure(let error):
                print("error: \(error)")
                completion(APIResult.failure(error))
            }
        }
    }
}
