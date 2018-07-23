//
//  LeaderboardViewModel.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/22/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

class LeaderboardViewModel {
    static var currentTournament: Tournament?
    
    static var players = [Player]()
    typealias FetchCompletion = (() -> ())
    static let playerURL: String = "https://ixgihulbxi.execute-api.us-east-1.amazonaws.com/dev/players"
    static let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
    
    
    static func fetchPlayers(completion: FetchCompletion?) {
        Alamofire.request(playerURL).responseArray(queue: userInteractiveQueue, keyPath: "body.players") { (response: DataResponse<[Player]>) in
            if let playerArray = response.result.value {
                for player in playerArray {
                    players.append(player)
                }
            }
            
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
    
}
