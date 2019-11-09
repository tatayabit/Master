//
//    Condition.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Condition : Codable {

    let condition : String?
    let operatorValue : String?
    let value : String?
    let conditions : [Condition]?
    let set : String?
    let setValue : String?


    enum CodingKeys: String, CodingKey {
        case condition = "condition"
        case operatorValue = "operator"
        case value = "value"
        case conditions = "conditions"
        case set = "set"
        case setValue = "set_value"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        condition = try values.decodeIfPresent(String.self, forKey: .condition)
        operatorValue = try values.decodeIfPresent(String.self, forKey: .operatorValue)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        conditions = try values.decodeIfPresent([Condition].self, forKey: .conditions)
        set = try values.decodeIfPresent(String.self, forKey: .set)
        setValue = try values.decodeIfPresent(String.self, forKey: .setValue)
    }


}
