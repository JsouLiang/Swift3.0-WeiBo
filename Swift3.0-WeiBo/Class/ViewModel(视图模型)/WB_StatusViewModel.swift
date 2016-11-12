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
class WB_StatusViewModel: CustomStringConvertible {
    
    /// 微博模型
    var status: WB_Status
    /// 会员图标
    var memberIcon: UIImage?
    var vipIcon: UIImage?
    /// 转发文字
    var retweetedStr: String?
    /// 评论文字
    var commentStr: String?
    /// 点赞文字
    var likeStr: String?
    
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
        
        // 底部栏信息
        retweetedStr = countString(count: status.reposts_count, descrpition: "转发")
        commentStr = countString(count: status.comments_count, descrpition: "评论")
        likeStr = countString(count: status.attitudes_count, descrpition: "赞")
    }
    
    var description: String {
        return status.description
    }
    
    /// 将传入的数子与description拼接
    ///
    /// - Parameters:
    ///   - count: 数字
    ///   - descrpition: 描述字符串
    /// - Returns: 拼接后字符串
    private func countString(count: Int, descrpition: String) -> String {
        if count == 0 {
            return descrpition
        } else if count < 10000 {
            return "\(count)" + descrpition
        } else {
            return String(format: "%.2f万", Double(count/10000))
        }
    }

}
