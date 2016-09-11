//
//  WB_BaseViewController.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 16/9/5.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

class WB_BaseViewController: UIViewController {
    
    /// 如果用户没有登录, tableView 不显示, 不创建
    var tableView: UITableView?
    
    /// 自定义导航条 View
    lazy var navigationBar: UINavigationBar = { [weak self] () -> UINavigationBar in
        let navigationBar =  self?.createNavigationBar()
        return navigationBar!
    }()
    
    /// 自定义导航数据 Model
    lazy var navigationBarItem: UINavigationItem = { () -> UINavigationItem in
        let navigationBarItem = UINavigationItem()
        return navigationBarItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    /// 加载数据, 不做任何实现, 具体实现由子类负责
    func loadData() {
        
    }
}


// MARK: - 
//: 注意 
//: 1. Extension 中不能有属性

extension WB_BaseViewController {
    public func setupUI() -> Void {
        navigationController?.navigationBar.isHidden = true
        self.view.addSubview(navigationBar)
        setUpTableView()
    }
    
    /// 重写设置 title 方法, 将传递的 title 数据赋值到自定义的 navigationItem -> navigationBar
    override var title: String? {
        didSet {
            self.navigationBarItem.title = title
        }
    }
    
    private func setUpTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        // 设置数据源和代理
        tableView?.delegate = self
        tableView?.dataSource = self
        
        view.insertSubview(tableView!, aboveSubview: navigationBar)
    }
    
    private func createNavigationBar() -> UINavigationBar {
        let navBar = UINavigationBar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 64))
        navBar.items = [navigationBarItem]
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]
        return navBar
    }
}


// MARK: - TableView数据源, 代理, 基类只是负责准备方法, 子类负责具体的实现, 子类的数据源不需要 super.
extension WB_BaseViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
