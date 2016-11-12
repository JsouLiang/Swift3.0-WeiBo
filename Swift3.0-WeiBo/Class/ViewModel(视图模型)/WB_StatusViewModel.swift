//
//  WB_StatusViewModel.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/12.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import Foundation

/// 单条微博的视图模型
/**
 * 如果没有任何父类，如果希望在开发中输出对象内容信息需要
 * 1. 遵循CustomStringConvertible协议
 * 2. 实现description计算属性
 */
class WN_StatusViewModel: CustomStringConvertible {
    
    /// 微博模型
    var status: WB_Status
    /// 会员图标
    var memberIcon: UIImage?
    var vipIcon: UIImage?
    
    init(status: WB_Status) {
        self.status = status
        // 直接计算出会员图标
        if (status.user?.mbrank)! > 0 &&
           (status.user?.mbrank)! < 7{
            let imageName = ""
            memberIcon = UIImage(named: imageName)
        }
        
        // 计算vip认证图标
        switch status.user?.verified_type ?? -1{
        case 0:
            vipIcon = UIImage(named: "")
        case 2, 3, 5:
            vipIcon = UIImage(named: "")
        case 220:
            vipIcon = UIImage(named: "")
        default:
            break
        }
    }
    
    var description: String {
        return status.description
    }
}
