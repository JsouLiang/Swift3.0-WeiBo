//
//  WB_NewFeatureView.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/11.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

/// 新特性视图
class WB_NewFeatureView: UIView {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var enterButton: UIButton!
    
    class func newfeature() -> WB_NewFeatureView {
        let nib = UINib(nibName: "WB_NewFeatureView", bundle: nil)
        let view = nib.instantiate(withOwner: nib, options: nil)[0] as! WB_NewFeatureView
        view.frame = UIScreen.main.bounds
        return view
    }
  
    override func awakeFromNib() {
        // 如果使用自动布局设置的界面，从 XIB 加载默认是 600 * 600 大小
        // 添加 4 个图像视图
        let count = 4
        let rect = UIScreen.main.bounds
        
        for i in 0..<count {
            
            let imageName = "new_feature_\(i + 1)"
            let iv = UIImageView(image: UIImage(named: imageName))
            
            // 设置大小
            iv.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            
            scrollView.addSubview(iv)
        }
        
        // 指定 scrollView 的属性
        scrollView.contentSize = CGSize(width: CGFloat(count + 1) * rect.width, height: rect.height)
        
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = self
        
        // 隐藏按钮
    }
}

extension WB_NewFeatureView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        // 滚动到最后一页，让视图删除
        if page == scrollView.subviews.count {
            removeFromSuperview()
        }
        
        // 倒数第二页，显示按钮
        if page == scrollView.subviews.count - 1 {
            // 3. 如果是倒数第2页，显示按钮
            enterButton.isHidden = (page != scrollView.subviews.count - 1)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 0. 一旦滚动隐藏按钮
        enterButton.isHidden = true
        
        // 1. 计算当前的偏移量
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        
        // 2. 设置分页控件
        pageControl.currentPage = page
        
        // 3. 分页控件的隐藏
        pageControl.isHidden = (page == scrollView.subviews.count)
    }

}
