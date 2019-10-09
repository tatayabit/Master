//
//  ConciergeViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

struct ConciergeViewModel {
    private let apiClient = ConciergeAPIClient()

    //MARK:- Api
    func uploadConcierge(concierge: Concierge, completion: @escaping (APIResult<[String: String]?, MoyaError>) -> Void) {
        apiClient.uploadConcierge(concierge: concierge) { result in
            switch result {
            case .success(let uploadConciergeResult):
                print("uploadConciergeResult: \(String(describing: uploadConciergeResult))")
            case .failure(let error):
                print("the error \(error)")
            }
            completion(result)
        }
    }
}

extension Constants {
    struct Concierge {
        static let uploaded = "Uploaded".localized()
    }
}
