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
    
    /// 加载微博列表
    ///
    /// - Parameters:
    ///   - sinceId: 返回id比sinceId大的微博, 默认为0
    ///   - maxId: 返回id比maxId小的微博, 默认为0
    ///   - completion: 完成操作
    /// - Parameter complation: 完成操作list：微博字典数组， 是否成功
    func statusList(sinceId:Int64 = 0, maxId:Int64 = 0, complation: @escaping ([[String: Any]]?, Bool) -> ()) {
        let urlStr = "https://api.weibo.com/2/statuses/public_timeline.json"
        let params = ["since_id": "\(sinceId)",
            "max_id": "\(maxId > 0 ? maxId - 1 : 0)"]
        
        // 常规写法
        /*
        request(URLString: urlStr, paramaters: params, complation: { (json, isSuccess) in
            
        })*/
        // 尾随闭包
        tokeRequest(URLString: urlStr, paramaters: params){ (json, isSuccess) in
            guard let result = json as? [String: AnyObject], let statuses = result["statuses"] else {
                return
            }
            complation(statuses as? [[String : Any]], isSuccess)
        }
    }
}
