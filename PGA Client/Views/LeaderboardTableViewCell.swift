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
            posLabel.text = "\(player?.position ?? "")"
            playerLabel.text = "\(player?.name ?? "")"
            if let thru = player?.thru {
                if thru == 18 {
                    thruLabel.text = "F"
                } else {
                    thruLabel.text = "\(String((player?.thru)!))"
                }
            } else {
                thruLabel.text = "-"
            }
            
            if let score = player?.totalScore {
                if score < 0 {
                    totalScoreLabel.textColor = MainTheme.textColorUnderPar
                    totalScoreLabel.text = "\(String((player?.totalScore)!))"
                } else if score == 0 {
                    totalScoreLabel.textColor = MainTheme.textColorEven
                    totalScoreLabel.text = "Even"
                } else {
                    totalScoreLabel.textColor = MainTheme.textColorOverPar
                    totalScoreLabel.text = "+\(String((player?.totalScore)!))"
                }
            } else {
                totalScoreLabel.textColor = MainTheme.textColor
                totalScoreLabel.text = "-"
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
                todayScoreLabel.text = "-"
            }
        }
    }
    
    let posLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.textColor = MainTheme.textColor
        label.textAlignment = .center
        return label
    }()
    
    let totalScoreLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.textColor = MainTheme.textColor
        label.textAlignment = .center
        return label
    }()
    
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
        label.textAlignment = .center
        return label
    }()
    
    let thruLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.textColor = MainTheme.textColor
        label.textAlignment = .center
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
        addSubview(posLabel)
        addSubview(playerLabel)
        addSubview(totalScoreLabel)
        addSubview(todayScoreLabel)
        addSubview(thruLabel)
        
        // Horizontal Constraints
        addConstraintsWithFormat(format: "H:|-16-[v0(32)]-8-[v1]", views: posLabel, playerLabel)
        addConstraintsWithFormat(format: "H:[v0(32)]-[v1(40)]-[v2(32)]-16-|", views: totalScoreLabel, thruLabel, todayScoreLabel)
        addConstraint(NSLayoutConstraint(item: playerLabel, attribute: .right, relatedBy: .equal, toItem: totalScoreLabel, attribute: .left, multiplier: 1.0, constant: 0))
        
        // Vertical Constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: posLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: playerLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: totalScoreLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: thruLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: todayScoreLabel)
    }
}
