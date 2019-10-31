//
//  SignUpViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/4/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

struct SignUpViewModel {

    let apiClient = UserAPIClient()

    //MARK:- Api

    func signUp(user: User, completion: @escaping (APIResult<SignUpResponse?, MoyaError>) -> Void) {

        apiClient.signUp(user: user) { result in
            switch result {
            case .success(let signupResult):
                print(signupResult!)
                guard let signUpResponse = signupResult else { return }

                self.apiClient.getProfile(userId: signUpResponse.userId, completion: { profileResult in
                    switch profileResult {
                    case .success(let profileResponse):
                        guard let userResponse = profileResponse else { return }
                        print(userResponse)
                        Customer.shared.setUser(userResponse)
                    case .failure(let profileError):
                        print("the profile error \(profileError)")
                    }
//                    completion(profileResult)
                })
            case .failure(let error):
                print("the error \(error)")
//                completion(error)

            }
            completion(result)
        }
    }
    

}
