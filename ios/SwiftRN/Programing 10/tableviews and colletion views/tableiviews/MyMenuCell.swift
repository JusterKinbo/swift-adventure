//
//  MyMenuCell.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/8/18.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit

//留下此文件的目的表示MunuController 没使用成功
class MyMenuCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @nonobjc let copy1 = #selector(MyMenuCell.copy_)
    @nonobjc let test1 = #selector(MyMenuCell.test)
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == copy1 || action == test1
    }
    
    
    @objc func test(_ sender:UIMenuItem) {
        print("test")
    }
    
    @objc func copy_(_ sender:UIMenuItem) {
        print("copy")
    }
}
