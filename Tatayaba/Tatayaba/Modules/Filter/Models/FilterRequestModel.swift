//
//  FilterRequestModel.swift
//  Tatayaba
//
//  Created by new on 1/14/20.
//  Copyright © 2020 Shaik. All rights reserved.
//

struct FilterRequestModel {
    var page:String
    var sort_by: [String]?
    var sort_order: String?
    var cat_ids: [String]?
    var supplier_ids: [String]?
    var min: String?
    var max: String?
    var searchText : String?
    
    init(page:String ,sort_by: [String],sort_order: String,cat_ids: [String],supplier_ids: [String],min: String,max: String,searchText:String) {
        self.page = page
        self.sort_by = sort_by
        self.sort_order = sort_order
        self.cat_ids = cat_ids
        self.supplier_ids = supplier_ids
        self.min = min
        self.max = max
        self.searchText = searchText
    }
}
