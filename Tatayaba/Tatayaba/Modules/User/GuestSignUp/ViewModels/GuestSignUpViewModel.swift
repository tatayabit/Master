//
//  GuestSignUpViewModel.swift
//  Tatayaba
//
//  Created by Elsman on 9/10/19.
//  Copyright Elsman. All rights reserved.
//

import Moya

struct GuestSignUpViewModel {

    let apiClient = UserAPIClient()

    //MARK:- Api

    func guestSignUp(user: User, completion: @escaping (APIResult<User?, MoyaError>) -> Void) {

        apiClient.guestSignUp(user: user) { result in
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
                    completion(profileResult)
                })
            case .failure(let error):
                print("the error \(error)")
                 completion(APIResult.failure(error))
            }
        }
    }
    

}
