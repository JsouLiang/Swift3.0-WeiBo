//
//  UIImage+Extension.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/12.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

extension UIImage {
    
    /// 通过Core Image将传入的image进行拉伸并返回拉伸后的image
    ///
    /// - Parameters:
    ///   - originalImage: 原始image
    ///   - canvasSize: 画布尺寸，绘图尺寸（将原图像绘制到多大的画布上）
    /// - Returns: 拉伸后的image
    func stretchImage(canvasSize: CGSize) -> UIImage? {
        let rect = CGRect(origin: CGPoint(), size: canvasSize)
        // 上下文， 在内存中开辟地址
        /*
         * size: 绘图尺寸
         * opaque: 是否不透明，false->透明， true -> 不透明
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        // 绘图 drawInRect 就是将图像绘制到指定的rect区域内
        self.draw(in: rect)
        // 取得结果
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    /// 创建圆形图像
    ///
    /// - Parameters:
    ///   - originalImage: 原图像
    ///   - canvasSize: 画布尺寸，绘图尺寸（将原图像绘制到多大的画布上）
    ///   - backgroundColor: 画布背景颜色
    /// - Returns: 圆形图片
    func generateCirclePicture(canvasSize: CGSize?, backgroundColor: UIColor = UIColor.white) -> UIImage? {
        
        var size = canvasSize
        if size == nil {
            size = self.size
        }
        let rect = CGRect(origin: CGPoint(),
                          size: size!)
        
        // 上下文， 在内存中开辟地址
        /*
         * size: 绘图尺寸
         * opaque: 是否不透明，false->透明， true -> 不透明
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        // 设置画布颜色
        backgroundColor.setFill()
        UIRectFill(rect)
    
        // 设置圆形路径
        let path = UIBezierPath(ovalIn: rect)
        // 进行路径裁切, 后续的绘图只会出现在路径内容，外部的都会被裁切（相当于将画布根据路径裁切）
        path.addClip()
        // 绘图 drawInRect 就是将图像绘制到指定的rect区域内
        self.draw(in: rect)
        
        
        let ovalPth = UIBezierPath(ovalIn: rect)
        // 设置路径颜色
        UIColor.lightGray.setStroke()
        ovalPth.lineWidth = 1
        ovalPth.stroke()
        
        // 取得结果
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        return resultImage
    }

}
