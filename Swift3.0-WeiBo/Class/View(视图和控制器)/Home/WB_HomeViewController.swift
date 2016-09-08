//
//  WB_HomeViewController.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 16/9/7.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

class WB_HomeViewController: WB_BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc private func handleAddFriendAction(barButtonItem: UIBarButtonItem) -> Void {
        
    }

}

extension WB_HomeViewController {
    override func setupUI() {
        super.setupUI()
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(title: "好友",
                                                           target: self,
                                                           selected: #selector(WB_HomeViewController.handleAddFriendAction(barButtonItem:)))
    }
}
