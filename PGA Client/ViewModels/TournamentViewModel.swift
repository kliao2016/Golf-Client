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
    static var tournament: Tournament?
    typealias FetchCompletion = (() -> ())
    static let tournamentURL = "https://ixgihulbxi.execute-api.us-east-1.amazonaws.com/dev/tournament"
    static let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
    
    // Method to fetch current tournaments
    static func fetchTournament(completion: FetchCompletion?) {
        Alamofire.request(tournamentURL).responseObject(queue: userInteractiveQueue, keyPath: "body") { (response: DataResponse<Tournament>) in
            if let tournamentResponse = response.result.value {
                tournament = tournamentResponse
            }
            
            DispatchQueue.main.async {
                completion?()
            }
        }
        
    }
}
