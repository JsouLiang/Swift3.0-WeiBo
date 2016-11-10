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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, selected: #selector(autoFull))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 加载授权页面
        // 加载授权页面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_AppKey)&redirect_uri=\(WN_RedirectURI)"
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
    
    //MARK: 监听方法
    @objc private func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: 自动填充
    @objc private func autoFull() {
        // 准备js，让webView自动执行
        let js = "document.getElementById('userId').value = '15764238014'; " +
        "document.getElementById('passwd').value = 'WGL1129584401';"
        webView.stringByEvaluatingJavaScript(from: js)
        
    }
}
