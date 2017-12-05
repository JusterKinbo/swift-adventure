//
//  RuntimePropertyListViewController.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/9/12.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit


class TestClass
{
    var sex = true
    var age = 22
    var name = "Janny"
    @objc //不加上@objc方法找不到，原因应该在于runtime 是 OC的，只能去查找OC的方法
    func sayHello(to name:String)  {
        print("\(self.name) hello to \(name)")
    }
}


class RuntimePropertyListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        getMethodAndPropertyFromClass(cls: TestClass.self)
        getMethodAndPropertyFromClass(cls: RuntimePropertyListViewController.self)
        //method swizzle
        swizleMethod(cls: RuntimePropertyListViewController.self, originSelector: #selector(RuntimePropertyListViewController.viewDidAppear(_:)), destinationSelector: #selector(RuntimePropertyListViewController.my_viewDidAppear(_:)))
       swizleMethod(cls: RuntimePropertyListViewController.self, originSelector: #selector(RuntimePropertyListViewController.returnInt(value:)), destinationSelector: #selector(RuntimePropertyListViewController.my_ReturnInt(value:)))
        returnInt(value: 3)
        //设置关联
        self.descriptiveName = "lalala"
        print(self.descriptiveName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc dynamic func returnInt(value:Int) -> Int
    {
        print("origin return int")
        return value
    }
    @objc dynamic func my_ReturnInt(value:Int) -> Int
    {
        print("swizzle return int")
        return value
    }
    //交换方法
    func swizleMethod(cls:AnyClass!,originSelector:Selector,destinationSelector:Selector)
    {
        let origin = class_getInstanceMethod(cls,originSelector)
        let dest = class_getInstanceMethod(cls,destinationSelector)
        method_exchangeImplementations(origin!, dest!)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("origin view did appear")
    }
    @objc func my_viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
        print("swizzle view did appear")
       
    }

    
    func getMethodAndPropertyFromClass(cls:AnyClass)
    {
        print("methods\n")
        var methodNum:UInt32 = 0
        let methods = class_copyMethodList(cls, &methodNum)
    
        
        for index in 0..<numericCast(methodNum)
        {
            let m:Method = methods![index]
            print("method name : \(method_getName(m))")
            print("method returnType:\(String(cString:method_copyReturnType(m)))")
            print("method type encodeing:\(String(cString:method_getTypeEncoding(m)!))")
        }
        print("properties\n")
        var proNum:UInt32 = 0
        let properties = class_copyIvarList(cls, &proNum)
        
    
        
        for index in 0..<numericCast(proNum)
        {
            let p:objc_property_t = properties![index]
            print("property name:\(String(cString:property_getName(p)))")
            print("property attribute:\(String(cString:property_getAttributes(p)!))")
        }
    }
}

//设置关联
extension UIViewController {
    private struct AssociatedKeys {
        static var DescriptiveName = "nsh_DescriptiveName"
    }
    var descriptiveName: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.DescriptiveName,
                    newValue as NSString?,
                    objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC
                )
            }
        }
    }
}
