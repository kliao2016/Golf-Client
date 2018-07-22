//
//  TournamentViewModel.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/8/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

class TournamentViewModel {
    var tournament: Tournament?
    var players: [Player]?
    typealias FetchCompletion = (() -> ())
    let tournamentURL: String = "https://ixgihulbxi.execute-api.us-east-1.amazonaws.com/dev/tournament"
    let playerURL: String = "https://ixgihulbxi.execute-api.us-east-1.amazonaws.com/dev/players"
    let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
    
    // Method to fetch current tournaments
    func fetchTournament(completion: FetchCompletion?) {
        Alamofire.request(tournamentURL).responseObject(queue: userInteractiveQueue, keyPath: "body") { (response: DataResponse<Tournament>) in
            if let tournamentResponse = response.result.value {
                self.tournament = tournamentResponse
            }
            
            DispatchQueue.main.async {
                completion?()
            }
        }
        
    }
    
    func fetchPlayers(completion: FetchCompletion?) {
        Alamofire.request(playerURL).responseArray(queue: userInteractiveQueue, keyPath: "body") { (response: DataResponse<[Player]>) in
            if let playerArray = response.result.value {
                for player in playerArray {
                    self.players?.append(player)
                }
            }
            
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
}
