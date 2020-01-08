//
//  FilterSettings.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 1/6/20.
//  Copyright © 2020 Shaik. All rights reserved.
//

struct FilterSettings {
    
    enum SortingOptions: String {
        case ascending = "asc"
        case descending = "desc"
    }
    
//    enum FilterOptions: String {
//        case featuredFirst = "featured_first"
//        case price = "price"
//        case averageRating = "average_rating"
//        case popularity = "popularity"
//    }
    
    var freeDelivery: Bool = false
    var sorting: SortingOptions = .ascending
    var filter: String = "featured_first"
    
    func isUsingDefalutValues() -> Bool {
        return self.sorting == .ascending && self.filter == "featured_first"
    }
}
