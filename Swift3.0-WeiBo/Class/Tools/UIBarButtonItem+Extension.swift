//
//  UIBarButtonItem+Extension.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 16/9/8.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    
    /// 创建自定义 BarButtonItem(通过 UIButton 创建)
    ///
    /// - parameter title:               标题
    /// - parameter fontSize:            字体大小(默认16号)
    /// - parameter normalTextColor:     正常状态下字体颜色(默认深灰色)
    /// - parameter highlightdTextColor: 正常状态下高亮颜色(默认橙色)
    /// - parameter target:              操作目标
    /// - parameter selected:            操作方法
    ///
    /// - returns: 实例化的 BarButtonItem对象
    convenience init(title: String, fontSize: CGFloat = 16,
                     normalTextColor: UIColor = UIColor.darkGray,
                     highlightdTextColor: UIColor = UIColor.orange,
                     target: AnyObject?, selected: Selector) {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        button.setTitleColor(normalTextColor, for: .normal)
        button.setTitleColor(highlightdTextColor, for: .highlighted)
        button.addTarget(target, action: selected, for: .touchUpInside)
        button.sizeToFit()
        
        self.init(customView: button)
    }
}
