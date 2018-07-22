//
//  Tournament.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/8/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import Foundation
import ObjectMapper

struct Tournament: Mappable {
    var tour: String?
    var name: String?
    var dateRange: String?
    var course: String?
    var rounds: Int?
    var currentRound: Int?
    var lastUpdated: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        tour            <- map["tour"]
        name            <- map["current_tournament"]
        dateRange       <- map["date"]
        course          <- map["course"]
        rounds          <- map["rounds"]
        currentRound    <- map["current_round"]
        lastUpdated     <- map["last_updated"]
    }
    
}
