//
//  WB_WelcomeView.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/11.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit
import SDWebImage

/// 欢迎视图
class WB_WelcomeView: UIView {
    @IBOutlet weak var iconViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    class func welcomView() -> WB_WelcomeView {
        let nib = UINib(nibName: "WB_WelcomeView", bundle: nil)
        let view = nib.instantiate(withOwner: nib, options: nil)[0] as! WB_WelcomeView
        view.frame = UIScreen.main.bounds
        return view
    }
    
    override func awakeFromNib() {
        guard let urlStr = WB_NetworkManager.sharedManager.userAccount.avatar_large else {
            return
        }
        iconImageView.sd_setImage(with: URL(string: urlStr),
                                  placeholderImage: UIImage(named: "avatar_default_big"))
    }
    
    // 视图被添加到window上会执行
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        iconViewTopConstraint.constant = 100

        UIView.animate(withDuration: 1.5,
                       animations: {
                        self.layoutIfNeeded()
                        self.nameLabel.alpha = 1.0
        }, completion: {(finish: Bool) -> Void in
            self.removeFromSuperview()
        })
    }
}
