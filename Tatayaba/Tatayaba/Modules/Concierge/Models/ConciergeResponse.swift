//
//  ConciergeResponse.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 11/23/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct ConciergeResponse {
    var status: String
    
    init(status: String = "") {
        self.status = status
    }
}

extension ConciergeResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case status
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(status, forKey: .status)
    }
}
