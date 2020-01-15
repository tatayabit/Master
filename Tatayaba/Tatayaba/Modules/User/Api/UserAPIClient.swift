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

    static let environment: APIEnvironment = .dev3

    func signUp(user: User, completion: @escaping (APIResult<SignUpResponse?, MoyaError>) -> Void) {
        fetch(with: UserEndpoint.signUp(user: user), completion: completion)
    }
    
    func guestSignUp(user: User, completion: @escaping (APIResult<SignUpResponse?, MoyaError>) -> Void) {
        fetch(with: UserEndpoint.gusetSignUp(user: user), completion: completion)
    }

    func login(user: User, completion: @escaping (APIResult<LoginResult?, MoyaError>) -> Void) {
        fetch(with: UserEndpoint.login(user: user), completion: completion)
    }
    
    func forgetPassword(email: String, completion: @escaping (APIResult<ForgetPasswordResult?, MoyaError>) -> Void) {
        fetch(with: UserEndpoint.forgetPassword(email: email), completion: completion)
    }

    func getProfile(userId: Int, completion: @escaping (APIResult<User?, MoyaError>) -> Void) {
        fetch(with: UserEndpoint.getProfile(userId: String(userId)), completion: completion)
    }
    
    func updateProfile(user: User, completion: @escaping (APIResult<SignUpResponse?, MoyaError>) -> Void) {
        print(UserEndpoint.updateProfile(user: user))
        fetch(with: UserEndpoint.updateProfile(user: user), completion: completion)
    }

}
