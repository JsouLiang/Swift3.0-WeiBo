//
//  WB_User.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/12.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

/// 微博用户模型
class WB_User: NSObject {
    // 基本数据类型和private不能使用KVC设置
    var id: Int64 = 0
    
    /// 用户昵称
    var screen_name: String?
    
    /// 用户头像地址
    var profile_image_url: String?
    
    /// 认证类型， -1 没有认证，0 认证用户， 2， 3，5: 企业认证， 220 达人
    var verified_type: Int = 0
    /// 会员等级 0 - 6
    var mbrank: Int = 0
    
    override var description: String {
        return yy_modelDescription()
    }
}
