//
//  WB_NavigationController.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 16/9/5.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

class WB_NavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 如果不是根控制器
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
}
