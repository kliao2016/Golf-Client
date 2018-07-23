//
//  LeaderboardViewController.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/22/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    let reuseIdentifier = "LeaderboardCell"
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        LeaderboardViewModel.fetchPlayers { [unowned self] in
            self.tableView.reloadData()
        }
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Leaderboard"
        let exitImage = UIImage.init(named: "exit")?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: exitImage, style: .done, target: self, action: #selector(dismissView))
        
        addConstraints()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.CustomColors.light
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
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let trackAction = UITableViewRowAction(style: .default, title: "Track Player") { (action, indexpath) in
            print("Tracking player")
        }
        
        trackAction.backgroundColor = UIColor.CustomColors.green
        return [trackAction]
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
        
        cell.player = LeaderboardViewModel.players[indexPath.row]
        
        return cell
    }
    
    
}


