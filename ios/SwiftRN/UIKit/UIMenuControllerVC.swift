//
//  UIMenuControllerVC.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/8/21.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//


/*
 UIMenuController的使用
    * 首先要想显示必须要键盘弹出来才可以
    * select slectAll paste必须存在
    * 自定义menuItem是在上面三者后新增的一个选项
    * becomeFirstResponder是针对可编辑的view
 
 */
import UIKit

class UIMenuControllerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         self.view.backgroundColor=UIColor.white
        
        let textField = UITextField(frame: CGRect(x:100,y:100,width:100,height:50))
        textField.text = "啦啦啦"
        textField.borderStyle = .roundedRect
        
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 80, y: 200, width: 200, height: 30)
        btn.setTitle("点我显示menu", for: .normal)
        btn.addTarget(self, action: #selector(showMenu(sender:)), for: .touchUpInside)
        
        self.view.addSubview(textField)
        self.view.addSubview(btn)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let actionReset = #selector(UIMenuControllerVC.resetPiece(controller:))

    @objc  func showMenu(sender:UIButton)
    {
        print("show menu")
        let menu = UIMenuController.shared
         let menuItemTitle = NSLocalizedString("Reset", comment: "Reset menu item title")
               let resetMenuItem = UIMenuItem(title: menuItemTitle, action: actionReset)
        
        // Configure the shared menu controller
        let menuController = UIMenuController.shared
        menuController.menuItems = [resetMenuItem]
        menu.setTargetRect(CGRect(x:0,y:150,width:0,height:0), in: self.view)
        menu.setMenuVisible(true, animated: true)
    }
    
//    //开始点击
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("开始点击")
//        let menu = UIMenuController.shared
//        let point = touches.first?.location(in: self.view)
//        menu.setTargetRect(CGRect(x:(point?.x)!,y:(point?.y)!,width:300,height:30), in: self.view)
//       menu.setMenuVisible(true, animated: true)
//       
//    }
//    //移动
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("移动")
//    }
//    //点击结束
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("点击结束")
//    }
    @objc func resetPiece(controller:ViewController)
    {
        print("resetPiece")
    }
    override func becomeFirstResponder() -> Bool {
        print("becomeFirstResponder")
        return true
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        print("canPerformAction")
        return action == actionReset
    }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
