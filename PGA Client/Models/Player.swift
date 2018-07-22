//
//  Player.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/8/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import Foundation
import ObjectMapper

class Player: Mappable {
    
    var name: String?
    var position: String?
    var curScore: Int?
    var totalScore: Int?
    var fedexRanking: Int?
    var fedexPts: Int?
    var projectedFedexRanking: Int?
    var projectedFedexPts: Int?
    var totalShots: Int?
    var rounds: [Int]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name                    <- map["name"]
        position                <- map["position"]
        curScore                <- map["today_score"]
        totalScore              <- map["total_score"]
        fedexRanking            <- map["fedex_ranking"]
        fedexPts                <- map["fedex_points"]
        projectedFedexRanking   <- map["projected_fedex_ranking"]
        projectedFedexPts       <- map["projected_fedex_points"]
        totalShots              <- map["total_shots"]
        rounds                  <- map["rounds"]
    }
}
