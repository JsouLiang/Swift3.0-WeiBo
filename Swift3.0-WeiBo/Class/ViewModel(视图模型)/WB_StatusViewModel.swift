//
//  WB_StatusViewModel.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/12.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import Foundation

/// 单条微博的视图模型
class WN_StatusViewModel {
    
    /// 微博模型
    var status: WB_Status
    
    init(status: WB_Status) {
        self.status = status
    }
}
