//
//  UpdateProfileViewModel.swift
//  Tatayaba
//
//  Created by Ahmed Elsman on 11/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

struct UpdateProfileViewModel {

    let apiClient = UserAPIClient()

    //MARK:- Api

    func updateProfile(user: User, completion: @escaping (APIResult<User?, MoyaError>) -> Void) {

        apiClient.updateProfile(user: user) { result in
            switch result {
            case .success(let updateProfileResult):
                print(updateProfileResult!)
                guard let updateProfileResponse = updateProfileResult else { return }

                self.apiClient.getProfile(userId: updateProfileResponse.userId, completion: { profileResult in
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
//                completion(error)

            }
//            completion(result)
        }
    }
    

}
