//
//  WB_MainViewController.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 16/9/5.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

class WB_MainViewController: UITabBarController {

    fileprivate lazy var composeButton: UIButton = { () -> UIButton
        in
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        button.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChildViewController()
        setupComposeButton()
    }

    
    /// portraint: 竖屏, 肖像模式
    /// landspace: 横屏, 风景模式
    /// 在需要横屏的时候可以单独处理, 当设置好方向后, 其控制器, 子控制器都会使用设置好的方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func handleComposeAction(composeButton: UIButton) -> Void {
        
    }
}

// extension 中不能定义属性，只能定义方法
extension WB_MainViewController {
    
    /// 添加加号按钮
    fileprivate func setupComposeButton() {
        tabBar.addSubview(composeButton)
        // 设置加号按钮 frame
        let count: CGFloat = CGFloat(childViewControllers.count)
        let width = tabBar.bounds.width / count - 1
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * width, dy: 0)
        composeButton.addTarget(self, action: #selector(WB_MainViewController.handleComposeAction(composeButton:)), for: .touchUpInside)
    }
    
    /// 设置所有子控制器
    fileprivate func setUpChildViewController() {
        let childViewControllerInfos = [
            ["className": "WB_HomeViewController", "title": "首页", "imageName": "home"],
            ["className": "WB_MessageViewController", "title": "消息", "imageName": "message_center"],
            ["className": "", "title": "", "imageName": ""],
            ["className": "WB_DiscoverViewController", "title": "发现", "imageName": "discover"],
            ["className": "WB_ProfileViewController", "title": "我", "imageName": "profile"],
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
    fileprivate func controller(info: [String: String]) -> UIViewController {
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
        viewController.tabBarItem.image = UIImage(named: "tabbar_" + imageName)?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 设置 TabBar 字体
        viewController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.orange], for: .highlighted)
        
        let nav = WB_NavigationController(rootViewController: viewController)
        return nav
    }
    
   
}
