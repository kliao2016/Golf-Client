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
            playerLabel.text = player?.name
        }
    }
    
    let playerLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.textColor = MainTheme.textColor
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
        addSubview(playerLabel)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]|", views: playerLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: playerLabel)
    }
}
