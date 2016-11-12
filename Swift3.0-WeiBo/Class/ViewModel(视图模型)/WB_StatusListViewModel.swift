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
// 上拉刷新最大尝试次数
private let maxPullUpTryTimes = 3

/*
 * 如果类需要使用KVC，或者字典转模型设置对象值，那么这个类需要继承自NSObject，反之不需要继承NSObject
 */
class WB_StatusListViewModel {
    /// 微博视图模型数组懒加载
    lazy var statusList = [WN_StatusViewModel]()
   
    /// 上拉刷新错误次数
    private var pullupErrorTime = 0
    
    /// 加载微博列表
    ///
    /// - Parameters:
    ///   - pullUp: 是否上拉加载更多
    ///   - completion: 完成操作(isSuccess: 网络请求是否成功， hasMorePullUp：是否刷新表格）
    func loadStatus(pullUp: Bool, completion: @escaping (_ isSuccess: Bool,_ shouldRefreshTable: Bool) -> ()) {
        // 是否是上拉刷新
        if pullUp && pullupErrorTime > maxPullUpTryTimes {
            completion(false, false)
        }
        
        
        // sinceId 下拉，取出数组中第一条微博数据的id
        let sinceId = pullUp ? 0 : (statusList.first?.status.id ?? 0)
        // 上拉刷新，取出数组最后一条微博的id
        let maxId = !pullUp ? 0 : (statusList.last?.status.id ?? 0)
        
        WB_NetworkManager.sharedManager.statusList(sinceId: sinceId, maxId: maxId) { (list, isSuccess) in
            
            // 判断网络是否成功
            if !isSuccess {
                completion(false, false)
                return
            }
            
            // 1, 字典转模型
            guard let array = NSArray.yy_modelArray(with: WB_Status.self, json: list ?? []) as? [WB_Status] else {
                completion(isSuccess, false)
                return
            }
            
           let viewModelArray = array.map({ (status) -> WN_StatusViewModel in
                return WN_StatusViewModel(status: status)
            })
            
            if pullUp {
                // 上拉刷新将新数据拼接在已有数据后面
                self.statusList += viewModelArray
            } else {
                // 下拉刷新，将结果数组拼接在数组前面
                self.statusList = viewModelArray + self.statusList
            }
            // 2. 上拉刷新的次数
            if pullUp && array.count == 0 {
                self.pullupErrorTime += 1
                completion(isSuccess, false)
            } else {
                completion(isSuccess, true)
            }
        }
    }
}
