//
//  ProfileViewController+DataSource.swift
//  Course2FinalTask
//
//  Created by Павел on 05.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let user = user else { return 1 }
        let postsCount = DataProviders.shared.postsDataProvider.findPosts(by: user.id)!.count
        return postsCount
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfileFeedCell.self), for: indexPath) as? ProfileFeedCell else { return UICollectionViewCell() }
        if let user = user {
            cell.post = DataProviders.shared.postsDataProvider.findPosts(by: user.id)?[indexPath.item]
        }
        cell.backgroundColor = .red
        return cell
    }
    
    
}
