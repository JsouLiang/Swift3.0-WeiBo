//
//  WB_HomeViewController.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 16/9/7.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

private let cellIdentifier = "HomeTableViewCell"

class WB_HomeViewController: WB_BaseViewController {

    /// 微博数据数组
    lazy private var statusList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<20 {
            statusList.insert(String(i), at: i)
        }
    }

    @objc private func handleAddFriendAction(barButtonItem: UIBarButtonItem) -> Void {
        
    }

}

extension WB_HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = statusList[indexPath.row]
        return cell
    }
}

extension WB_HomeViewController {
    override func setupUI() {
        super.setupUI()
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, selected: #selector(WB_HomeViewController.handleAddFriendAction(barButtonItem:)))
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}
