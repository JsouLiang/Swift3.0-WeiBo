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
            
            if viewController is WB_BaseViewController {
                var title = "返回"
                let leftItem = UIBarButtonItem(title: title, target: self, selected:  #selector(WB_NavigationController.pop), isBackItem:true, backImageName: "navigationbar_back")
                
                // 判断控制器层数, 如果是第二层控制器, 显示第一层的标题
                if childViewControllers.count == 1 {
                    // 显示上一页标题
                    title = (childViewControllers.first?.title) ?? "返回"
                }
                let vc = viewController as! WB_BaseViewController
                vc.navigationBarItem.leftBarButtonItem = leftItem
            }
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func pop() -> Void {
        popViewController(animated: true)
    }
}

