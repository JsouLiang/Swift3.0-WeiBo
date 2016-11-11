//
//  WB_MainViewController.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 16/9/5.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit
import SVProgressHUD
class WB_MainViewController: UITabBarController {

    fileprivate var timer: Timer?
    
    deinit {
        // 销毁时钟
        timer?.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
    
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
        delegate = self
        setUpChildViewController()
        setupComposeButton()
        
        // 注册通知
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userLogin),
                                               name: NSNotification.Name(rawValue: WB_UserShouldLoginNotification),
                                               object: nil)
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

extension WB_MainViewController {
    /// 定义时钟
    fileprivate func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    /// 时钟触发方法
    @objc private func updateTimer() {
        if WB_NetworkManager.sharedManager.userLogon {
            // 微博未读数量
            WB_NetworkManager.sharedManager.unreadCount(){ (count) in
                // 设置首页tabbar badgeNumber
                self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
                
                // 设置App图标的badgeNumber
                // 从iOS8 之后要有用户授权才可以显示
                UIApplication.shared.applicationIconBadgeNumber = count
            }
        }
    }
    
    @objc fileprivate func userLogin(notify: Notification) {
        var when = DispatchTime.now()
        if notify.object != nil {
            SVProgressHUD.showInfo(withStatus: "用户登录已超时，需重新登录")
            SVProgressHUD.setDefaultMaskType(.gradient)
            when += DispatchTime.now() + 1.5
        }
        DispatchQueue.main.asyncAfter(deadline: when) {
            SVProgressHUD.setDefaultMaskType(.clear)

            // 用户登录
            let nav = UINavigationController(rootViewController: WB_OAuthViewController())
            self.present(nav, animated: true, completion: nil)
        }
    }
}

// extension 中不能定义属性，只能定义方法
extension WB_MainViewController {
    
    /// 添加加号按钮
    fileprivate func setupComposeButton() {
        tabBar.addSubview(composeButton)
        // 设置加号按钮 frame
        let count: CGFloat = CGFloat(childViewControllers.count)
        let width = tabBar.bounds.width/count
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * width, dy: 0)
        composeButton.addTarget(self, action: #selector(WB_MainViewController.handleComposeAction(composeButton:)), for: .touchUpInside)
    }
    
    /// 设置所有子控制器
    fileprivate func setUpChildViewController() {
        
        // 获取沙盒json路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        // 加载Data
        var data = NSData(contentsOfFile: jsonPath)
        if data == nil {
            // 从bundle中加载
             let path = Bundle.main.path(forResource: "main.json", ofType: nil)
             data = NSData(contentsOfFile: path!)
        }
        
        // data 一定会有内容
        // 反序列化
        guard let childViewControllerInfos = try! JSONSerialization.jsonObject(with: data as! Data, options: []) as? [[String: Any]] else{
            return
        }
        
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
    fileprivate func controller(info: [String: Any]) -> UIViewController {
        let namespace = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        guard let className = info["className"] as? String,
              let title = info["title"] as? String,
              let imageName = info["imageName"] as? String,
              let cls = NSClassFromString(namespace + "." + className) as? WB_BaseViewController.Type, 
              let visitorInfo = info["visitorInfo"] as? [String: String]
            else {
                    return UIViewController()
        }
        // 创建视图控制器
        let viewController =  cls.init()
        viewController.title = title
        viewController.tabBarItem.image = UIImage(named: "tabbar_" + imageName)?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 设置控制器的访客信息字典
        viewController.visitorInfo = visitorInfo
        
        // 设置 TabBar 字体
        viewController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.orange], for: .highlighted)
        
        let nav = WB_NavigationController(rootViewController: viewController)
        return nav
    }
    
   
}

extension WB_MainViewController: UITabBarControllerDelegate {
    
    /// 将要选择tabBarItem
    ///
    /// - Parameters:
    ///   - tabBarController: tabBarController
    ///   - viewController: 目标控制器
    /// - Returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // 获取控制器在数组中的索引
        let index = (childViewControllers as NSArray).index(of: viewController)
        
        // 当前索引是首页同时index也是首页，相当于重复点击首页
        if selectedIndex == 0 && index == selectedIndex {
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! WB_HomeViewController
            
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                vc.loadData()
            }
        }
        return !viewController.isMember(of: UIViewController.self)
    }
}
