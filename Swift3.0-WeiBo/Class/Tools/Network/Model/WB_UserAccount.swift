//
//  WB_UserAccount.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/10.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

/// 用户账号信息
class WB_UserAccount: NSObject {
    var access_token: String?
    // 用户代号
    var uid: String?
    /// 过期日期，单位秒
    var expires_in: TimeInterval = 0.0
    override var description: String {
        return yy_modelDescription()
    }
}
