//
//  FilterSettings.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 1/6/20.
//  Copyright © 2020 Shaik. All rights reserved.
//

struct FilterSettings {
    
    enum SortingOptions: String {
        case none
        case ascending = "asc"
        case descending = "desc"
    }
    
    enum FilterOptions: String {
        case none
        case featuredFirst = "featured_first"
        case price = "price"
        case averageRating = "average_rating"
        case popularity = "popularity"
    }
    
    var freeDelivery: Bool = false
    var sorting: SortingOptions = .none
    var filter: FilterOptions = .none
}
