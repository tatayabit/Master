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

    func signUp(user: User, completion: @escaping (APIResult<User?, MoyaError>) -> Void) {
        apiClient.signUp(user: user, completion: completion)
    }

}
