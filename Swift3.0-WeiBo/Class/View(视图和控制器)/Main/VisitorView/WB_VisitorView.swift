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
    
    /// 注册按钮
    lazy var registerButton: UIButton = UIButton.cz_textButton(
        "注册",
        fontSize: 16,
        normalColor: UIColor.orange,
        highlightedColor: UIColor.black,
        backgroundImageName: "common_button_white_disable")
    
    /// 登录按钮
    lazy var loginButton: UIButton = UIButton.cz_textButton(
        "登录",
        fontSize: 16,
        normalColor: UIColor.darkGray,
        highlightedColor: UIColor.black,
        backgroundImageName: "common_button_white_disable")

    
    /// - parameter dict: [imageName 对应iconImageView的image/ message对应tipLabel 的内容]
    /// 如果是首页 imageName: ""
    var visitorViewInfo: [String: String]? {
        // 1. 通过willSet设置信息
//        willSet {
//            // 1. 取出字典信息
//            guard let imageName: String = newValue?["imageName"],
//                let message = newValue?["message"] else {
//                    return
//            }
//            tipLabel.text = message
//            let image = imageName == "" ? UIImage(named: "visitordiscover_feed_image_house") : UIImage(named: imageName)
//            iconImagView.image = image
//        }
        // 2. 通过didSet设置信息
        didSet {
            // 1. 取出字典信息
            guard let imageName: String = visitorViewInfo?["imageName"],
                let message = visitorViewInfo?["message"] else {
                    return
            }
            tipLabel.text = message
            let image = imageName == "" ? UIImage(named: "visitordiscover_feed_image_house") : UIImage(named: imageName)
            iconImagView.image = image
            startAnimation()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func startAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * M_PI
        animation.repeatCount = MAXFLOAT
        animation.duration = 15.0
        animation.isRemovedOnCompletion = false
        backgroundImagView.layer.add(animation, forKey: nil)
    }

    // MARK: 私有属性，方法
    // 懒加载只有调用UIKit的指定的构造函数或者便利构造函数不需要加类型，其他的都需要加类型
    // 背景图片视图
    fileprivate lazy var backgroundImagView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    // Icon
    fileprivate lazy var iconImagView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    // 遮罩视图
    fileprivate lazy var maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    // 提示标签
    fileprivate lazy var tipLabel: UILabel = UILabel.cz_label(
        withText: "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜",
        fontSize: 14,
        color: UIColor.darkGray)
}

extension WB_VisitorView {
    fileprivate func setupUI() {
        backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        tipLabel.textAlignment = .center
        // 添加控件
        addSubview(backgroundImagView)
        addSubview(maskIconView)
        addSubview(iconImagView)
        addSubview(tipLabel)
        addSubview(loginButton)
        addSubview(registerButton)
        // 自动布局
        self.setupLayout()
    }
    
    private func setupLayout() {
        let margin: CGFloat = 20.0
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
        addConstraint(NSLayoutConstraint(item: iconImagView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        addConstraint(NSLayoutConstraint(item: iconImagView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
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
        // maskIconView
        // views: 定义VFL中空间的名称和实际名称的映射关系
        let views: [String: UIView] = ["maskIconView": maskIconView,
                                       "registerButton": registerButton]
        // metrics: 定义VFL中（）指定的常数映射关系
        let metrics = ["spacing": -35]
        // 水平约束
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[maskIconView]-0-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views:views))
        // 垂直约束
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[registerButton]",
                                                      options: [],
                                                      metrics: metrics,
                                                      views:views))
        

    }
}
