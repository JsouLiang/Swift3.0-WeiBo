//
//  WB_UserAccount.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/10.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit
private let accountFileName: NSString = "user_account.json"
/// 用户账号信息
class WB_UserAccount: NSObject {
    var access_token: String?
    // 用户代号
    var uid: String?
    /// 过期日期，单位秒
    var expires_in: TimeInterval = 0.0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    // 过期日期
    var expiresDate: Date?
    
    override init() {
        super.init()
        // 从磁盘加载保存的文件 -> 得到字典
       guard let filePath = accountFileName.cz_appendDocumentDir(),
        let data = NSData(contentsOfFile: filePath),
        let dict = try? JSONSerialization.jsonObject(with: (data as Data), options: []) as? [String: Any] else {
            return
        }
        
        // 使用字典设置属性值
        yy_modelSet(with: dict ?? [:])
        
        // 判断token是否过期
        if expiresDate?.compare(Date()) != .orderedDescending {
            print("账户过期")
            // 清空token
            access_token = nil; uid = nil
            // 删除账户文件
            try? FileManager.default.removeItem(atPath: filePath)
        }
        
    }
    
    override var description: String {
        return yy_modelDescription()
    }
    
    func saveAccount() {
        // 1. 模型转字典
        var dict = self.yy_modelToJSONObject() as? [String: Any] ?? [:]
        _ = dict.removeValue(forKey: "expires_in")
        // 字典序列化data
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
            let fileName = (accountFileName).cz_appendDocumentDir() else {
                return
        }
        // 写入磁盘
        (data as NSData).write(toFile: fileName, atomically: true)
    }
}
