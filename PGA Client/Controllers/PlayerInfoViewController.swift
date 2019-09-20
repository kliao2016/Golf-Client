//
//  PlayerInfoViewController.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/24/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import UIKit

class PlayerInfoViewController: UIViewController {
    
    @IBOutlet weak var cupImageView: UIImageView!
    @IBOutlet weak var cupRank: UILabel!
    @IBOutlet weak var cupPoints: UILabel!
    @IBOutlet weak var projectedRank: UILabel!
    @IBOutlet weak var projectedPoints: UILabel!
    @IBOutlet weak var round1: UILabel!
    @IBOutlet weak var round2: UILabel!
    @IBOutlet weak var round3: UILabel!
    @IBOutlet weak var round4: UILabel!
    @IBOutlet weak var trackButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var rank: Int?
    var points: Int?
    var projRank: Int?
    var projPoints: Int?
    var firstScore: Int?
    var secondScore: Int?
    var thirdScore: Int?
    var fourthScore: Int?
    var playerName = "Player"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = MainTheme.accent
        self.navigationItem.title = playerName
        self.view.backgroundColor = MainTheme.background
        contentView.backgroundColor = MainTheme.background
        
        trackButton.backgroundColor = MainTheme.textColorEven
        trackButton.layer.cornerRadius = 5.0
        
        cupRank.determineText(number: rank)
        cupPoints.determineText(number: points)
        projectedRank.determineText(number: projRank)
        projectedPoints.determineText(number: projPoints)
        
        round1.layer.masksToBounds = true
        round2.layer.masksToBounds = true
        round3.layer.masksToBounds = true
        round4.layer.masksToBounds = true
        
        round1.layer.cornerRadius = 5.0
        round2.layer.cornerRadius = 5.0
        round3.layer.cornerRadius = 5.0
        round4.layer.cornerRadius = 5.0
        
        round1.determineText(number: firstScore)
        round2.determineText(number: secondScore)
        round3.determineText(number: thirdScore)
        round4.determineText(number: fourthScore)
        
        round1.determineBackgroundColor(score: firstScore)
        round2.determineBackgroundColor(score: secondScore)
        round3.determineBackgroundColor(score: thirdScore)
        round4.determineBackgroundColor(score: fourthScore)
        
        cupImageView.image = UIImage.init(named: "award")?.withRenderingMode(.alwaysTemplate)
        if let cRank = rank {
            if cRank <= 10 {
                cupImageView.tintColor = MainTheme.textColorEven
            } else {
                cupImageView.tintColor = MainTheme.textColorUnderPar
            }
        } else {
            cupImageView.tintColor = MainTheme.accent
        }
    }

}

extension UILabel {
    func determineBackgroundColor(score: Int?) {
        if let round = score {
            if round < (LeaderboardViewModel.currentTournament?.par)! {
                self.backgroundColor = MainTheme.textColorUnderPar
            } else if round > (LeaderboardViewModel.currentTournament?.par)! {
                self.backgroundColor = MainTheme.textColorOverPar
            } else {
                self.backgroundColor = MainTheme.textColorEven
            }
        } else {
            self.backgroundColor = MainTheme.textColorEven
        }
    }
    
    func determineText(number: Int?) {
        if let num = number {
            self.text = String(num)
        } else {
            self.text = "--"
        }
    }
}
