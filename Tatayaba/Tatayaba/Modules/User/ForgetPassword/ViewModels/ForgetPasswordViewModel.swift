//
//  LoginViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/3/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

struct ForgetPasswordViewModel {

    let apiClient = UserAPIClient()

    //MARK:- Api

    func forgetPassword(email: String, completion: @escaping (APIResult<ForgetPasswordResult?, MoyaError>) -> Void) {
        apiClient.forgetPassword(email: email) { result in
            switch result {
            case .success(let forgePasswordResult):
                print(forgePasswordResult!)
                guard let forgePasswordResponse = forgePasswordResult else { return }
                print("forgePasswordResponse: \(forgePasswordResponse)")
            case .failure(let error):
                print("the error \(error)")
                //                completion(error)

            }
            completion(result)
        }
    }

}
