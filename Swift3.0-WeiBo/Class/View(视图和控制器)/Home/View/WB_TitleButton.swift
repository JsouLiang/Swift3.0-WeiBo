//
//  WB_TitleButton.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/11.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

class WB_TitleButton: UIButton {
    // title 如果是nil，就显示首页，如果不为nil，就显示title箭头
    init(title: String?) {
        super.init(frame: CGRect())
        if title == nil {
            setTitle("首页", for: .normal)
            setTitle("首页", for: .highlighted)
        } else {
            setTitle(title, for: .normal)
            setTitle(title, for: .highlighted)
            setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
            setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        }
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: .normal)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
