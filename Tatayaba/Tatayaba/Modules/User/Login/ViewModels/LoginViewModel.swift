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
                Customer.shared.setUser(loginResultResponse.user)
            case .failure(let error):
                print("the error \(error)")
                //                completion(error)

            }
        }
    }

}
