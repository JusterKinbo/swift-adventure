//
//  MyTableViewNibCell.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/8/15.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit

class MyTableViewNibCell: UITableViewCell {

    @IBOutlet weak var theImageView: UIImageView!
    @IBOutlet weak var theLabel: UILabel!

    @IBAction func click(_ sender: Any) {
        //点击没有感觉，这个问题有待解决。。
        print("点击了btn")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("selected")
        // Configure the view for the selected state
    }

}
