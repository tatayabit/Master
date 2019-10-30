//
//  ErrorMessage.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/30/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct ErrorMessage {
    var status: Int
    var message: String
}

extension ErrorMessage: Codable {
    enum CodingKeys: String, CodingKey {
        case status
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decodeIfPresent(Int.self, forKey: .status) ?? 0
        message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(message, forKey: .message)
    }
}
