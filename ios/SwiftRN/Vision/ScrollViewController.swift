//
//  VisionViewController.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/11/9.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//


import UIKit
import Vision
import CoreML


/**
 * 个人建议Scroll内部添加一个1像素的view，作为参照
 * Scroll内部添加子控件做约束很尴尬的，没有办法它的anchor全部做参考，一般只是用上左，另外的两个下右不同同时与上左使用
 * scrollview 如果想滚动必须设置contentSize
 * 如何自适应scrollView的高度，考虑使用获取内部最高的y做height
 */
class ScrollViewController: UIViewController {
 
    var sc:UIScrollView!
  
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
    }
    ///这里修改contentSize
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
        if let scr = sc
        {
//            scr.contentSize = CGSize(width:UIScreen.main.bounds.width,height:1000)
            var height = scr.frame.size.height
            
            if let v =  scr.subviews.last
            {
                let tmp = v.frame.origin.y + v.frame.size.height
                height = height > tmp ? height : tmp
            }
            scr.contentSize = CGSize(width:scr.frame.size.width,height:height)
            print("contentViewSize",sc.contentSize)
        }
        
    }
    override func viewDidLayoutSubviews() {
        print("view did LayoutSubviews")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        
        
//        sc = UIScrollView(frame: CGRect(x:25,y:80,width:UIScreen.main.bounds.width-50,height:300))
        sc = UIScrollView()
        
        self.view.addSubview(sc)
        sc.backgroundColor = .green
        self.view.backgroundColor = .gray
        
      
        
        let v1 = UIView();
        v1.backgroundColor = .red
        
        let v2 = UIView()
         v2.backgroundColor = .blue
        
        sc.addSubview(v1)
        sc.addSubview(v2)
       
        
        var con = [NSLayoutConstraint]()
        
        sc.translatesAutoresizingMaskIntoConstraints = false
        v1.translatesAutoresizingMaskIntoConstraints = false
        v2.translatesAutoresizingMaskIntoConstraints = false
        
        con.append(sc.topAnchor.constraint(equalTo: self.view.topAnchor))
        con.append(sc.leftAnchor.constraint(equalTo: self.view.leftAnchor))
        con.append(sc.rightAnchor.constraint(equalTo: self.view.rightAnchor))
        con.append(sc.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        
       
        
        con.append(v1.centerXAnchor.constraint(equalTo: sc.centerXAnchor))
        con.append(v1.widthAnchor.constraint(equalToConstant: 200))
        con.append(v1.heightAnchor.constraint(equalToConstant: 220))
        con.append(v1.topAnchor.constraint(equalTo: sc.topAnchor, constant: 10))
        
        con.append(v2.topAnchor.constraint(equalTo: v1.bottomAnchor, constant: 20))
        con.append(v2.centerXAnchor.constraint(equalTo: v1.centerXAnchor))
        con.append(v2.widthAnchor.constraint(equalToConstant: 200))
        con.append(v2.heightAnchor.constraint(equalToConstant: 400))
       
        
        
        NSLayoutConstraint.activate(con)
        
       
    }
    
    
}



