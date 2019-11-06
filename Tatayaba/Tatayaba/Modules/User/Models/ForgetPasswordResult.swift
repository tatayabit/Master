//
//  LoginResult.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/4/19.
//  Copyright © 2019 Shaik. All rights reserved.
//


struct ForgetPasswordResult {
    var success: Int
    var msg: String
    
    init(success: Int = 0, msg: String = "") {
        self.success = success
        self.msg = msg
    }
    
}

extension ForgetPasswordResult: Codable {
    enum CodingKeys: String, CodingKey {
        case success
        case msg
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decodeIfPresent(Int.self, forKey: .success) ?? 0
        msg = try container.decodeIfPresent(String.self, forKey: .msg) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(success, forKey: .success)
        try container.encodeIfPresent(msg, forKey: .msg)
    }
}
