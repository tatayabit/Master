//
//  LoginViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/3/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

struct LoginViewModel {

    let apiClient = UserAPIClient()

    //MARK:- Api

    func login(user: User, completion: @escaping (APIResult<LoginResult?, MoyaError>) -> Void) {
        apiClient.login(user: user) { result in
            switch result {
            case .success(let loginResult):
                print(loginResult!)
                guard let loginResultResponse = loginResult else { return }
                
                print("loginResultResponse: \(loginResultResponse)")
//                self.apiClient.getProfile(userId: signUpResponse.userId, completion: { profileResult in
//                    switch profileResult {
//                    case .success(let profileResponse):
//                        guard let userResponse = profileResponse else { return }
//
//                        print(userResponse)
//                    case .failure(let profileError):
//                        print("the profile error \(profileError)")
//                    }
//                    completion(profileResult)
//                })
            case .failure(let error):
                print("the error \(error)")
                //                completion(error)

            }
        }
    }

}
