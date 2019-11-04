//
//  Country.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/18/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct Country {
    var code: String
    var name: String

    init(code: String = "", name: String = "") {
        self.code = code
        self.name = name
    }
}

extension Country: Codable {
    enum CodingKeys: String, CodingKey {
        case code
        case name
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        code = try container.decodeIfPresent(String.self, forKey: .code) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(name, forKey: .name)
    }
}
