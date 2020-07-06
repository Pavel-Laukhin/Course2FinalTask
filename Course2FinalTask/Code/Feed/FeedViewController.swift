//
//  FeedViewController.swift
//  Course2FinalTask
//
//  Created by Павел on 02.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

protocol TransitionProtocol: AnyObject {
    func showProfile(userId: User.Identifier)
    func showListOfUsersLikedThisPost(postId: Post.Identifier)
}

extension FeedViewController: TransitionProtocol {
    func showListOfUsersLikedThisPost(postId: Post.Identifier) {
        var users: [User] = []
        let usersIdArray = DataProviders.shared.postsDataProvider.usersLikedPost(with: postId)
        
        // ДОбавляем в массив юзеров, лайкнувших пост:
        usersIdArray?.forEach { userId in
            if let user = DataProviders.shared.usersDataProvider.user(with: userId) {
                users.append(user)
            }
        }
        
        // Показываем таблицу с юзерами:
        navigationController?.pushViewController(TableViewController(users: users, title: "Likes"), animated: true)
    }
    
    func showProfile(userId: User.Identifier) {
        let user = DataProviders.shared.usersDataProvider.user(with: userId)
        navigationController?.pushViewController(ProfileViewController(user: user), animated: true)
    }
    
    
}

class FeedViewController: UIViewController {
        
    private lazy var collectionView: UICollectionView = {
        // 1. Делаем дефолтный макет, иначе наша коллекшн вью не сможет понять, как ей отрисовывать наши ячейки на экране:
        let layout = UICollectionViewFlowLayout()
        // 2. Делаем экземпляр класса коллекшн вью. Можно передать во фрейм "зиро", то есть нулевой прямоугольник. Ничего страшного, потому что потом этот фрейм растянется, как нам надо:
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // 3. Регистрируем ячейку:
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: String(describing: FeedCell.self))
        // 4. Указываем наш контроллер источником информации и делегатом:
        collectionView.dataSource = self
        collectionView.delegate = self
        // 5.Возвращаем результат:
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        addSubviews()
        setUpSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    // Настраиваем размер коллекшн вью:
    private func setUpSubviews() {
        collectionView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: view.bounds.height
        )
    }
    
}
