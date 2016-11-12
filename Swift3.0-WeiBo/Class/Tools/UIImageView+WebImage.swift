//
//  UIImageView+WebImage.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/12.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import SDWebImage

extension UIImageView {
    
    /// 通过CoreImage 离屏渲染图片
    ///
    /// - Parameters:
    ///   - url: 图片URL
    ///   - placeholderImage: 占位图
    ///   - isAvatar: 是否是头像，是头像进行圆角
    func setImage(url: String?, placeholderImage: UIImage, isAvatar: Bool = false) {
        // URL
        guard let url = url, let imageURL = URL(string: url) else {
            // 设置占位图片
            image = placeholderImage
            return
        }
        sd_setImage(with: imageURL,
                    placeholderImage: placeholderImage,
                    options: [],
                    progress: nil) { [weak self]  (image, _, _, _) in
                        if isAvatar {
                           self?.image = image?.generateCirclePicture(canvasSize: self?.bounds.size)
                        }
        }
    }
}
