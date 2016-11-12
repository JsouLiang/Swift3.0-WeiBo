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
        loadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WB_StatusTableViewCell
        cell.statusInfo = listViewModel.statusList[indexPath.row]

        return cell
    }
}

// MARK: - 设置界面
extension WB_HomeViewController {
    override func setUpTableView() {
        super.setUpTableView()
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, selected: #selector(WB_HomeViewController.handleAddFriendAction(barButtonItem:)))
        tableView?.register(UINib.init(nibName: "WB_StatusNormalTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        // 设置行高
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 300
        // 取消分割线
        tableView?.separatorStyle = .none
        
        setupNavTitleView()
    }
    
    fileprivate func setupNavTitleView() {
        let title = WB_NetworkManager.sharedManager.userAccount.screen_name
        let button = WB_TitleButton(title: title)
        button.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
        navigationBarItem.titleView = button
    }
    
    @objc private func clickTitleButton(button: UIButton) -> Void {
        button.isSelected = !button.isSelected
    }
}
