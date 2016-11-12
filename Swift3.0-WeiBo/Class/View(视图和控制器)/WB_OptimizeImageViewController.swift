//
//  WB_OptimizeImageViewController.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/12.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

// 图像性能优化
class WB_OptimizeImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 常规设置图像方法会导致1. 图像拉伸CPU计算图像拉伸，2. PNG图片允许透明会导致混合图层的影响会消耗GPU资源，
        // 第一种可以通过模拟器中的Color blend layer查看（显示红色）
        // 第二种可以通过模拟器的Color Misaligned layer 查看，显示黄色
//        imageView.image = // #imageLiteral(resourceName: "avatar_default_big")
        imageView.image = generateCirclePicture(originalImage: #imageLiteral(resourceName: "avatar_default_big"),
                                                canvasSize: imageView.bounds.size,
                                                backgroundColor: view.backgroundColor)
    }
    
    /// 通过Core Image将传入的image进行拉伸并返回拉伸后的image
    ///
    /// - Parameters:
    ///   - originalImage: 原始image
    ///   - canvasSize: 画布尺寸，绘图尺寸（将原图像绘制到多大的画布上）
    /// - Returns: 拉伸后的image
    func stretchImage(originalImage: UIImage, canvasSize: CGSize) -> UIImage? {
        let rect = CGRect(origin: CGPoint(), size: canvasSize)
        // 上下文， 在内存中开辟地址
        /*
         * size: 绘图尺寸
         * opaque: 是否不透明，false->透明， true -> 不透明
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        // 绘图 drawInRect 就是将图像绘制到指定的rect区域内
        originalImage.draw(in: rect)
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
    func generateCirclePicture(originalImage: UIImage, canvasSize: CGSize, backgroundColor: UIColor?) -> UIImage? {
        let rect = CGRect(origin: CGPoint(), size: canvasSize)
        // 上下文， 在内存中开辟地址
        /*
         * size: 绘图尺寸
         * opaque: 是否不透明，false->透明， true -> 不透明
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
 
        // 设置画布颜色
        backgroundColor?.setFill()
        UIRectFill(rect)
        
        // 设置圆形路径
        let path = UIBezierPath(ovalIn: rect)
        // 设置路径颜色
        UIColor.gray.setStroke()
        path.lineWidth = 2
        path.stroke()
        
        // 进行路径裁切, 后续的绘图只会出现在路径内容，外部的都会被裁切（相当于将画布根据路径裁切）
        path.addClip()
        
        // 绘图 drawInRect 就是将图像绘制到指定的rect区域内
        originalImage.draw(in: rect)
        // 取得结果
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        return resultImage
    }
}
