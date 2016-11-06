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
    
    /// 列表视图模型
    fileprivate lazy var listViewModel = WB_StatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            }

    /// 加载数据
    override func loadData() {
        listViewModel.loadStatus(pullUp: self.isPullUp){ (isSuccess: Bool, shouldRefreshTable: Bool) -> () in
            if  shouldRefreshTable {
                // 结束刷新控件
                self.refreshControl?.endRefreshing()
                // 恢复上拉刷新标记
                self.isPullUp = false
                // 刷新表格
                self.tableView?.reloadData()
            }
        }

    }
    
    @objc fileprivate func handleAddFriendAction(barButtonItem: UIBarButtonItem) -> Void {
        
    }

}

extension WB_HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
//        cell.textLabel?.text = listViewModel.statusList[indexPath.row]
        return cell
    }
}

// MARK: - 设置界面
extension WB_HomeViewController {
    override func setUpTableView() {
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, selected: #selector(WB_HomeViewController.handleAddFriendAction(barButtonItem:)))
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}
