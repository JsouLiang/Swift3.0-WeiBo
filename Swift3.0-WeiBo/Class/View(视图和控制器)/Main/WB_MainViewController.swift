//
//  WB_MainViewController.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 16/9/5.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

class WB_MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
            setUpChildViewController()
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// extension 中不能定义属性，只能定义方法
extension WB_MainViewController {
    
    /// 设置所有子控制器
    private func setUpChildViewController() {
        let childViewControllerInfos = [
            ["className": "WB_HomeViewController", "title": "首页", "imageName": ""],
            ["className": "WB_MessageViewController", "title": "消息", "imageName": ""],
            ["className": "WB_DiscoverViewController", "title": "发现", "imageName": ""],
            ["className": "WB_ProfileViewController", "title": "我", "imageName": ""],
            ]
        
        let childViewControllers = childViewControllerInfos.map { (info: Dictionary) -> UIViewController in
            return self.controller(info: info)
        }
        
        viewControllers = childViewControllers

    }
    
    
    /// 使用字典创建子控制器
    ///
    /// - parameter info: 控制器信息[className: "控制器类", title: "标题", imageName: "图片名称"]
    ///
    /// - returns: 子控制器
    private func controller(info: [String: String]) -> UIViewController {
        let namespace = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        guard let className = info["className"],
              let title = info["title"],
              let imageName = info["imageName"],
              let cls = NSClassFromString(namespace + "." + className) as? UIViewController.Type
            else {
                    return UIViewController()
        }
        // 创建视图控制器
        let viewController =  cls.init()
        viewController.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)
        let nav = WB_NavigationController(rootViewController: viewController)
        return nav
    }
    
   
}
