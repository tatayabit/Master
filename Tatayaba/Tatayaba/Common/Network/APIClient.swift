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
    case qa
    case production
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
                    if response.statusCode >= 400 {
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
