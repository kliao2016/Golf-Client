//
//  TournamentCollectionViewCell.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/22/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import UIKit

class TournamentCollectionViewCell: UICollectionViewCell {

    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.transform = self.isSelected ? CGAffineTransform(scaleX: 0.95, y: 0.95) : CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    var tournament: Tournament? {
        didSet {
            tournamentName.text = tournament?.name
            dateRange.text = tournament?.dateRange
            tourLabel.text = (tournament != nil) ? tournament?.tour : "No Tournaments"
            courseName.text = tournament?.course
        }
    }
    
    let tournamentName: UILabel = {
        let label = UILabel()
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.textColor = MainTheme.textColor
        label.textAlignment = .center
        return label
    }()
    
    let courseName: UILabel = {
        let label = UILabel()
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.textColor = MainTheme.textColor
        label.textAlignment = .center
        return label
    }()
    
    let dateRange: UILabel = {
        let label = UILabel()
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 14)
        label.textColor = MainTheme.textColor
        label.textAlignment = .center
        return label
    }()
    
    let tourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 30)
        label.textColor = MainTheme.textColor
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let infoStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        self.createHoverEffect()
        self.backgroundColor = UIColor(patternImage: UIImage(named: "temp")!)
        self.contentMode = .scaleAspectFill
        
        infoStackView.insertArrangedSubview(tournamentName, at: 0)
        infoStackView.insertArrangedSubview(courseName, at: 1)
        infoStackView.insertArrangedSubview(dateRange, at: 2)
        
        addSubview(tourLabel)
        addSubview(infoStackView)
        
        // Horizontal constraints
        addConstraintsWithFormat(format: "H:|-16-[v0]|", views: tourLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: infoStackView)
        addConstraint(NSLayoutConstraint(item: infoStackView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        // Vertical constraints
        addConstraint(NSLayoutConstraint(item: tourLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: infoStackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
    }
    
    func createHoverEffect() {
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 2.5
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        self.layer.cornerRadius = 10.0
    }
    
    
}
