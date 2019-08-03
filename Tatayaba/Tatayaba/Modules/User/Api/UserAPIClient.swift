//
//  UserAPIClient.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/3/19.
//  Copyright © 2019 Shaik. All rights reserved.
//
import Moya


struct UserAPIClient: APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])

    static let environment: APIEnvironment = .production

    func signUp(user: User, completion: @escaping (APIResult<SignUpResponse?, MoyaError>) -> Void) {
          fetch(with: UserEndpoint.signUp(user: user), completion: completion)
    }

    func login(user: User, completion: @escaping (APIResult<SignUpResponse?, MoyaError>) -> Void) {
        fetch(with: UserEndpoint.login(user: user), completion: completion)
    }

    func getProfile(userId: Int, completion: @escaping (APIResult<User?, MoyaError>) -> Void) {
        fetch(with: UserEndpoint.getProfile(userId: userId), completion: completion)
    }

}
