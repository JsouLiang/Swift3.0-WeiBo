//
//  WB_VisitorView.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/10/26.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

/// 访客视图
class WB_VisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: 私有属性，方法
    // 懒加载只有调用UIKit的指定的构造函数或者便利构造函数不需要加类型，其他的都需要加类型
    // 背景图片视图
    fileprivate lazy var backgroundImagView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    // Icon
    fileprivate lazy var iconImagView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    // 提示标签
    fileprivate lazy var tipLabel: UILabel = UILabel.cz_label(
        withText: "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜",
        fontSize: 14,
        color: UIColor.darkGray)
    /// 注册按钮
    fileprivate lazy var registerButton: UIButton = UIButton.cz_textButton(
        "注册",
        fontSize: 16,
        normalColor: UIColor.orange,
        highlightedColor: UIColor.black,
        backgroundImageName: "common_button_white_disable")
    
    /// 登录按钮
    fileprivate lazy var loginButton: UIButton = UIButton.cz_textButton(
        "登录",
        fontSize: 16,
        normalColor: UIColor.darkGray,
        highlightedColor: UIColor.black,
        backgroundImageName: "common_button_white_disable")
}

extension WB_VisitorView {
    fileprivate func setupUI() {
        let margin: CGFloat = 20.0
        // 添加控件
        addSubview(backgroundImagView)
        addSubview(iconImagView)
        addSubview(tipLabel)
        addSubview(loginButton)
        addSubview(registerButton)
        // 自动布局
        // 1. 取消autoresizing
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        // 2. 布局
        // backgroundImageView 的水平居中
        addConstraint(NSLayoutConstraint(item: backgroundImagView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        // backgroundImageView 的垂直居中
        addConstraint(NSLayoutConstraint(item: backgroundImagView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0))
        
        // iconImagView 的x中心点与 backgroundImageView对其
        addConstraint(NSLayoutConstraint(item: iconImagView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: backgroundImagView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        // iconImagView 的y中心点与 backgroundImageView对其
        addConstraint(NSLayoutConstraint(item: iconImagView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: backgroundImagView,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0))
        // tipLabel
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: backgroundImagView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconImagView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 236))
        
        // registerButton
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        
        // loginButton
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))

    }
}
