//
//  TournamentCollectionViewController.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/7/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import UIKit

class TournamentCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "TournamentCell"
    private let cellsPerRow = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Tours"
        
        TournamentViewModel.fetchTournament { [unowned self] in
            self.collectionView?.reloadData()
            self.collectionViewLayout.invalidateLayout()
        }
        
        setupCollectionFlowLayout()
    }
    
    override func viewWillLayoutSubviews() {
        guard let collectionView = collectionView, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    private func setupCollectionFlowLayout() {
        guard let collectionView = collectionView, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 24
        flowLayout.sectionInset.top = 24
        flowLayout.sectionInset.bottom = 40
        flowLayout.sectionInset.left = 40
        flowLayout.sectionInset.right = 40
        
        collectionView.backgroundColor = MainTheme.background
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(TournamentCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
}

extension TournamentCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TournamentCollectionViewCell
        
        cell.tournament = TournamentViewModel.tournament
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if TournamentViewModel.tournament != nil {
            LeaderboardViewModel.currentTournament = TournamentViewModel.tournament
            let leaderboardVC = LeaderboardViewController()
            
            DispatchQueue.main.async { [unowned self] in
                self.present(UINavigationController(rootViewController: leaderboardVC), animated: true)
            }
        }
    }
    
}

