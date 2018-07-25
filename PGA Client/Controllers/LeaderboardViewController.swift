//
//  LeaderboardViewController.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/22/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LeaderboardViewController: UIViewController {
    
    let reuseIdentifier = "LeaderboardCell"
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainTheme.accent
        setupTableView()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = MainTheme.accent
        self.navigationItem.title = "Leaderboard"
        let exitImage = UIImage.init(named: "exit")?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: exitImage, style: .done, target: self, action: #selector(dismissView))
        
        addConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    private func loadData() {
        let activityFrame = CGRect(x: tableView.center.x - 30, y: tableView.center.y - 30, width: 60, height: 60)
        let activityIndicator = NVActivityIndicatorView(frame: activityFrame, type: NVActivityIndicatorType.circleStrokeSpin, color: MainTheme.accent, padding: 8)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        LeaderboardViewModel.fetchPlayers { [unowned self] in
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MainTheme.accent
        tableView.register(LeaderboardTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func addConstraints() {
        
        view.addSubview(tableView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: tableView)
    }
    
    @objc private func dismissView() {
        DispatchQueue.main.async { [unowned self] in
            self.dismiss(animated: true)
        }
    }
    

}

extension LeaderboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let playerInfoVC = sb.instantiateViewController(withIdentifier: "PlayerInfoViewController") as! PlayerInfoViewController
        playerInfoVC.rank = LeaderboardViewModel.players[indexPath.row % LeaderboardViewModel.players.count].fedexRanking
        playerInfoVC.points = LeaderboardViewModel.players[indexPath.row % LeaderboardViewModel.players.count].fedexPts
        playerInfoVC.projRank = LeaderboardViewModel.players[indexPath.row % LeaderboardViewModel.players.count].projectedFedexRanking
        playerInfoVC.projPoints = LeaderboardViewModel.players[indexPath.row % LeaderboardViewModel.players.count].projectedFedexPts
        playerInfoVC.firstScore = LeaderboardViewModel.players[indexPath.row % LeaderboardViewModel.players.count].rounds?[0]
        playerInfoVC.secondScore = LeaderboardViewModel.players[indexPath.row % LeaderboardViewModel.players.count].rounds?[1]
        playerInfoVC.thirdScore = LeaderboardViewModel.players[indexPath.row % LeaderboardViewModel.players.count].rounds?[2]
        playerInfoVC.fourthScore = LeaderboardViewModel.players[indexPath.row % LeaderboardViewModel.players.count].rounds?[3]
        playerInfoVC.playerName = LeaderboardViewModel.players[indexPath.row % LeaderboardViewModel.players.count].name ?? "Player"
        
        self.navigationController?.pushViewController(playerInfoVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let trackAction = UITableViewRowAction(style: .default, title: "Track Player") { (action, indexpath) in
            print("Tracking player")
        }
        
        trackAction.backgroundColor = UIColor.CustomColors.green
        return [trackAction]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = MainTheme.accent
        let posLabel = UILabel()
        let nameLabel = UILabel()
        let totalLabel = UILabel()
        let thruLabel = UILabel()
        let todayLabel = UILabel()
        posLabel.text = "Pos"
        nameLabel.text = "Player"
        totalLabel.text = "Tot"
        totalLabel.textAlignment = .center
        thruLabel.text = "Thru"
        thruLabel.textAlignment = .center
        todayLabel.text = "R\(String((LeaderboardViewModel.currentTournament?.currentRound)!))"
        todayLabel.textAlignment = .center
        headerView.addSubview(posLabel)
        headerView.addSubview(nameLabel)
        headerView.addSubview(totalLabel)
        headerView.addSubview(thruLabel)
        headerView.addSubview(todayLabel)
        
        headerView.addConstraintsWithFormat(format: "H:|-16-[v0(32)]-8-[v1]", views: posLabel, nameLabel)
        headerView.addConstraintsWithFormat(format: "H:[v0(32)]-[v1(40)]-[v2(32)]-16-|", views: totalLabel, thruLabel, todayLabel)
        headerView.addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: posLabel)
        headerView.addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: nameLabel)
        headerView.addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: totalLabel)
        headerView.addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: thruLabel)
        headerView.addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: todayLabel)
        headerView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: totalLabel, attribute: .left, multiplier: 1.0, constant: 0))
        
        return headerView
    }
    
    
}

extension LeaderboardViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LeaderboardViewModel.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LeaderboardTableViewCell
        
        let length = LeaderboardViewModel.players.count
        cell.player = LeaderboardViewModel.players[indexPath.row % length]
        
        let selectView = UIView()
        selectView.backgroundColor = UIColor.CustomColors.lightBlue
        cell.selectedBackgroundView = selectView
        
        return cell
    }
    
    
}


