//
//  WB_StatusListViewModel.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/6.
//  Copyright © 2016年 X-Liang. All rights reserved.
//


import Foundation

/// 微博数据列表视图模型：
/// 视图模型：
/// 1: 封装业务逻辑
/// 2: 封装网络处理
/// 3: 封装数据缓存

/// 微博数据列表视图模型的功能：
/// 1. 字典转模型 
/// 2. 上拉、下拉数据处理
/// 3. 下拉刷新数据
/// 4. 本地缓存数据处理

/*
 * 如果类需要使用KVC，或者字典转模型设置对象值，那么这个类需要继承自NSObject，反之不需要继承NSObject
 */
class WB_StatusListViewModel {
    /// 微博模型数组懒加载
    lazy var statusList = [WB_Status]()
    
    /// 加载微博列表
    ///
    /// - Parameters:
    ///   - sinceId: 返回id比sinceId大的微博, 默认为0
    ///   - maxId: 返回id比maxId小的微博, 默认为0
    ///   - completion: 完成操作
    func loadStatus(completion: @escaping (_ isSuccess: Bool) -> ()) {
        // sinceId 下拉，取出数组中第一条微博数据的id
        let sinceId = statusList.first?.id ?? 0
        let maxId = statusList.last?.id ?? 0
        
        WB_NetworkManager.sharedManager.statusList(sinceId: sinceId, maxId: maxId) { (list, isSuccess) in
            // 1, 字典转模型
            guard let array = NSArray.yy_modelArray(with: WB_Status.self, json: list ?? []) as? [WB_Status] else {
                completion(isSuccess)
                return
            }
            
            // 下拉刷新，将结果数组拼接在数组前面
            self.statusList = array + self.statusList
            // 2. 拼接数据
            self.statusList += array
            completion(isSuccess)
        }
    }
}
