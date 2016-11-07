//
//  WB_OAuthViewController.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/7.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

// 通过WbView加载新浪微博授权页面
class WB_OAuthViewController: UIViewController {
    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        title = "登录新浪微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", target: self, selected: #selector(close))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: 监听方法
    @objc private func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
