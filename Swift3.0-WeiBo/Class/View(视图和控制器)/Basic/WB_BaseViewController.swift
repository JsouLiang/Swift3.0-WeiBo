//
//  WB_BaseViewController.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 16/9/5.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

class WB_BaseViewController: UIViewController {
    
    /// 自定义导航条 View
    lazy var navigationBar: UINavigationBar = { [weak self] () -> UINavigationBar in
        let navigationBar = UINavigationBar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 64))
        navigationBar.items = [(self?.navigationBarItem)!]
        return navigationBar
    }()
    
    /// 自定义导航数据 Model
    lazy var navigationBarItem: UINavigationItem = { () -> UINavigationItem in
        let navigationBarItem = UINavigationItem()
        return navigationBarItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension WB_BaseViewController {
    public func setupUI() -> Void {
        navigationController?.navigationBar.isHidden = true
        self.view.addSubview(navigationBar)
    }
    
    /// 重写设置 title 方法, 将传递的 title 数据赋值到自定义的 navigationItem -> navigationBar
    override var title: String? {
        didSet {
            self.navigationBarItem.title = title
        }
    }
    
}
