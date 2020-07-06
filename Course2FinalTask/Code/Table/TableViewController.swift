//
//  TableViewController.swift
//  Course2FinalTask
//
//  Created by Павел on 06.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class TableViewController: UITableViewController {
    
    var lastSelectedRow: IndexPath?
    var currentlySelectedRow: IndexPath?
    
    var users: [User]
    
    // Настраиваем инициализатор, чтобы при инициализации передавался массив юзеров. Без этого массива нам табличный контроллер не нужен:
    init(users: [User], title: String) {
        self.users = users
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Регистрируем ячейку:
        tableView.register(TableViewCell.self, forCellReuseIdentifier: String(describing: TableViewCell.self))
    }
    
    // MARK: - Table view data source
    
    // Устанавливаем 1 секцию:
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    // Устанавливаем количество строк, равное количеству юзеров в массиве юзеров:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    // Устанавливаем многоразовую ячейку:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as? TableViewCell) else { return UITableViewCell() }
        
        // Configure the cell...
        cell.user = users[indexPath.row]
        
        return cell
    }
    
    // Устанавливаем высоту строки, равную 45 поинтов:
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentlySelectedRow = indexPath
        navigationController?.pushViewController(ProfileViewController(user: users[indexPath.row]), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Делаем так, чтобы подсветка строки не сразу исчезала, а с задержкой:
        if let row = currentlySelectedRow {
            tableView.cellForRow(at: row)?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            UIView.animate(withDuration: 0.6, delay: 0.1, options: .curveEaseIn, animations: {
                self.tableView.cellForRow(at: row)?.backgroundColor = .clear
            }, completion: nil)
        }
    }
    
}


