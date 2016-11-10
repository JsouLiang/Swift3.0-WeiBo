//
//  WB_OAuthViewController.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/7.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit
import SVProgressHUD

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
        webView.delegate = self
        webView.scrollView.isScrollEnabled = false
    }
    
    //MARK: 监听方法
    @objc fileprivate func close() {
        SVProgressHUD.dismiss()
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

extension WB_OAuthViewController: UIWebViewDelegate {
    
    /// webView 将要加载请求
    ///
    /// - Parameters:
    ///   - webView:
    ///   - request: 将要加载的请求
    ///   - navigationType:导航类型
    /// - Returns: 是否加载request
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print("----\(request.url?.absoluteString)")
        
        // 从http://www.baidu.com 回调地址中查询code
        if request.url?.absoluteString.hasPrefix(WN_RedirectURI) == false {
            return true
        }
        
        // 如果有code说明授权成功，否则授权失败
        // query 就是url中 ？后面中所有部分
        print("-----加载请求\(request.url?.query)")
        if request.url?.query?.hasPrefix("code=") == false {    // 取消授权
            self.close()
            return false
        }
        // 从query字符串中取出授权码
        let code = request.url?.query?.substring(from: "code=".endIndex) ?? ""
        // 成功授权，获得授权码
        WB_NetworkManager.sharedManager.loadAccessToken(code: code){(token) -> Void in
            
        }
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
