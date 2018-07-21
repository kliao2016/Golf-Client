//
//  Player.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/8/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import Foundation

class Player: NSObject {
    var name: String?
    var position: Int?
    var curRound: Round?
    var totalScore: Int?
    var fedexRanking: Int?
    var fedexPts: Int?
    var projectedFedexRanking: Int?
    var projectedFedexPts: Int?
    var totalShots: Int?
    var rounds: [Int]?
}

struct Round {
    var score: Int?
    var thru: Int?
}
