//
//  LeaderboardTableViewCell.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/22/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {
    var player: Player? {
        didSet {
            playerLabel.text = "\(player?.position ?? "") - \(player?.name ?? "")"
            
            if let thru = player?.thru {
                if thru == 18 {
                    thruLabel.text = "Thru: F"
                } else {
                    thruLabel.text = "Thru: \(String((player?.thru)!))"
                }
            } else {
                thruLabel.text = "Thru: -"
            }
            
            if let score = player?.todayScore {
                if score < 0 {
                    todayScoreLabel.textColor = MainTheme.textColorUnderPar
                    todayScoreLabel.text = "\(String((player?.todayScore)!))"
                } else if score == 0 {
                    todayScoreLabel.textColor = MainTheme.textColorEven
                    todayScoreLabel.text = "Even"
                } else {
                    todayScoreLabel.textColor = MainTheme.textColorOverPar
                    todayScoreLabel.text = "+\(String((player?.todayScore)!))"
                }
            } else {
                todayScoreLabel.textColor = MainTheme.textColor
                todayScoreLabel.text = "Today: No score yet"
            }
        }
    }
    
    let playerLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.textColor = MainTheme.textColor
        return label
    }()
    
    let todayScoreLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.textColor = MainTheme.textColor
        label.textAlignment = .right
        return label
    }()
    
    let thruLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.textColor = MainTheme.textColor
        label.textAlignment = .right
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = MainTheme.background
        addSubview(playerLabel)
        addSubview(todayScoreLabel)
        addSubview(thruLabel)
        
        // Horizontal Constraints
        addConstraintsWithFormat(format: "H:|-16-[v0]|", views: playerLabel)
        addConstraintsWithFormat(format: "H:|[v0]-16-|", views: todayScoreLabel)
        addConstraintsWithFormat(format: "H:|[v0]-16-|", views: thruLabel)
        addConstraint(NSLayoutConstraint(item: playerLabel, attribute: .width, relatedBy: .equal, toItem: todayScoreLabel, attribute: .width, multiplier: 1.0, constant: 0))
        
        // Vertical Constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: playerLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-[v1]-16-|", views: thruLabel, todayScoreLabel)
    }
}
