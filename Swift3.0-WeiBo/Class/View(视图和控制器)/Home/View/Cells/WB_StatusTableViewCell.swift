//
//  WB_StatusTableViewCell.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/12.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

class WB_StatusTableViewCell: UITableViewCell {
    /// 头像
    @IBOutlet weak var iconImageView: UIImageView!
    /// 姓名
    @IBOutlet weak var nameLabel: UILabel!
    /// 会员图标
    @IBOutlet weak var memberIconImageView: UIImageView!
    /// 时间
    @IBOutlet weak var timeLabel: UILabel!
    /// 来源
    @IBOutlet weak var sourceLabel: UILabel!
    /// VIP认证
    @IBOutlet weak var VIPIconImageView: UIImageView!
    /// 微博内容
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var bottomToolBar: WB_ToolBarView!
    /// 微博视图模型
    var statusInfo: WB_StatusViewModel? {
        didSet {
            self.nameLabel.text = statusInfo?.status.user?.screen_name
            self.statusLabel.text = statusInfo?.status.text
            // 设置会员图标
            memberIconImageView.image = statusInfo?.memberIcon
            // 设置vip认证图标
            VIPIconImageView.image = statusInfo?.vipIcon
            // 用户头像
            iconImageView.setImage(url: statusInfo?.status.user?.profile_image_url,
                                   placeholderImage: UIImage(named: "avatar_default_big")!, isAvatar: true)
            self.bottomToolBar.viewModel = statusInfo
        }
    }
    
}
