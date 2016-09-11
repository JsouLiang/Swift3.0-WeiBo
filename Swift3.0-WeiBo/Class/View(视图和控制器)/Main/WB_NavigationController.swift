//
//  WB_NavigationController.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 16/9/5.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

class WB_NavigationController: UINavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        
        // 如果不是根控制器
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            if viewController is WB_BaseViewController {
                var title = "返回"
                let leftItem = UIBarButtonItem(title: title, target: self, selected:  #selector(WB_NavigationController.pop), isBackItem:true, backImageName: "navigationbar_back")
                
                // 判断控制器层数, 如果是第二层控制器, 显示第一层的标题
                if childViewControllers.count == 1 {
                    // 显示上一页标题
                    title = (childViewControllers.first?.title) ?? "返回"
                }
                let vc = viewController as! WB_BaseViewController
                vc.navigationBarItem.leftBarButtonItem = leftItem
            }
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func pop() -> Void {
        popViewController(animated: true)
    }
}

class Vehicle {
    // 存储属性
    var numberOfWheels = 0
    
    // 计算属性
    // 必须声明为 Var 变量
    var readOnlyProperty: String {
        get {
            return "\(numberOfWheels) wheels"
        }
    }
    
    var readWriteProperty: String {
        get {
            return ""
        }
        set {
            self.readWriteProperty = newValue
        }
    }
}

let v = Vehicle()


class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
    override var readOnlyProperty: String {
        get {
            return "\(numberOfWheels) wheels"
        }
    }
}

class Car: Vehicle {
    var space = 0.0
    override init() {
        super.init()
        numberOfWheels = 4
    }
    
    override var readOnlyProperty: String {
        return super.readOnlyProperty + ", \(space)"
    }
}

class ParentsCar: Car {
    //  重写存储属性 , 自定义 setter, getter, 要提供 willSet, didSet
    override var space: Double {
        // 数据被更改之前调用
        willSet {
            if newValue > 65.0 {
                print("Careful now")
            }
        }
        // 数据被更改之后调用
        didSet {
            
        }
    }
}

struct Point {
    var x, y : Double
    
    mutating func moveToTheRightBy(dx: Double) {
        x += dx
    }
}

struct Size {
    var width, height: Double
}

struct Rect {
    var origin: Point
    var size: Size
    
    var area: Double {
        return size.width * size.height
    }
    
    func isBiggerThanRect(other: Rect) -> Bool {
        return self.area > other.area
    }
}

enum Planet: Int {
    case Mecury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

let earthNumber = Planet.Earth.rawValue

enum TrainStatus {
    case OnTime
    case Delayed(Int)
    
    var description: String {
        switch self {
        case .OnTime:
            return "on time"
            
        case .Delayed(let minutes):
            return "delayed by \(minutes) minutes"
        default:
            return ""
            
        }
    }
}

var status = TrainStatus.OnTime
//status = .Delayed(42)

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
//productBarcode = Barcode.qrCode("ABCDEFGHIJKLMNOP")


extension CGSize {
    mutating func increaseByFactor(factor: CGFloat) {
        width *= factor
        height *= factor
    }
}


class Person {
    var residence: Residence?
}

class Residence {
    var address: Address?
}

class Address {
    var buildingNumber: String?
    var streetName: String?
    var apartmentNumber: String?
}

let paul = Person()
let addressName = paul.residence?.address?.buildingNumber


