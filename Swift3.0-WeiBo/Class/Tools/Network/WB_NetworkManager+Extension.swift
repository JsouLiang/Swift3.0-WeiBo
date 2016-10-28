//
//  WB_NetworkManager+Extension.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/10/28.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import Foundation

// MARK: - 封装“新浪微博”的网络请求方法
extension WB_NetworkManager {
    
    /// 加载微博数据
    ///
    /// - Parameter complation: 完成操作list：微博字典数组
    func statusList(complation: @escaping (list: [[String: Any]]?, isSuccess: Bool) -> ()) {
        let urlStr = "https://api.weibo.com/2/statuses/public_timeline.json"
        let params = ["access_token": "2.00yyFj9D3UqMzDfca7866a25aFyA8D"]
        
        // 常规写法
        /*
        request(URLString: urlStr, paramaters: params, complation: { (json, isSuccess) in
            
        })*/
        // 尾随闭包
        request(URLString: urlStr, paramaters: params){ (json, isSuccess) in
            guard let result = json as? [String: AnyObject], let statuses = result["statuses"] else {
                return
            }
            complation(statuses as? [[String : Any]], isSuccess)
        }
    }
}
