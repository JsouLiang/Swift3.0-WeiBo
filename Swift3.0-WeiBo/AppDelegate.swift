//
//  AppDelegate.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 16/8/7.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow()
        guard let window = self.window else {
            return false
        }
        
        window.backgroundColor = UIColor.white
        window.rootViewController = WB_MainViewController()
        window.makeKeyAndVisible()
        
        loadAppInfo()
        setupAddition()
        return true
    }
}

// MARK: 从服务器加载应用程序信息
extension AppDelegate {
    fileprivate func loadAppInfo() {
        DispatchQueue.global().async {
            // 1. 获得URL
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            // 2. NSData
            let data = NSData(contentsOf: url!)
            // 3. 写入本地
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            
            data?.write(toFile: jsonPath, atomically: true)
        }
    }
}

// MARK: - 设置应用程序额外信息
extension AppDelegate {
    fileprivate func setupAddition() {
        // 设置SVProgressHUD的最小隐藏时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        // 设置网络加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        // 设置通知授权
        // #available 检测设备版本
        if #available(iOS 10.0, *) {
            // 取得用户授权，显示通知（提示条，声音，badgeNumber）
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound, .carPlay]){ (success, error) in
                print("授权" + (success ? "成功" : "失败"))
            }
        } else {
            let notificationSetting = UIUserNotificationSettings(types:  [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notificationSetting)
            
        }

    }
}


