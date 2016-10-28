//
//  WB_NetworkManager.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/10/28.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit
import AFNetworking

/// Swift枚举支持任意数据类型
enum WB_HTTPMethod {
    case GET
    case POST
}

/// 网络管理工具
class WB_NetworkManager: AFHTTPSessionManager {
    // 单例：1. 静态 2. 常量 3. 闭包
    // 在第一次访问时， 执行闭包， 并将结果存储在sharedManager静态常量中
    static let sharedManager = WB_NetworkManager()
    
    /// 使用一个函数封装AFN的GET/POST 请求
    func request(method: WB_HTTPMethod = .GET, URLString: String,
                 paramaters: [String: Any], complation: @escaping (Any?, Bool) -> (Void)) {
        let success = { (task: URLSessionTask, json: Any?) -> () in
            complation(json, true)
        }
        
        let failure = { (task: URLSessionTask?, error: Error) -> () in
            // error不需要传递到外部
            complation(nil, false)
        }
        
        if method == .GET {
            get(URLString, parameters: paramaters, progress: nil, success: success, failure: failure)
        } else {
            post(URLString, parameters: paramaters, progress: nil, success: success, failure: failure)
        }
    }
}
