//
//  NSIPViewController.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/10/19.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit

class BaseProjectViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
     var tableView:UITableView? = nil
    let cellIdentifier="nsipTBCell"
    let data=[
              ["title":"network","class":"NSIP_NetWorkViewController"],
              ["title":"填充数据","class":"BaseProjectViewController"]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="BASE PROJECT"
        let tb=UITableView.init(frame: UIScreen.main.bounds, style: .plain)
        self.tableView  = tb
        tb.tableFooterView=UIView(frame:.zero)
        
        tb.delegate=self
        tb.dataSource=self
        tb.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view = tb
    }

    //table view datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = data[indexPath.row]["title"]
        return cell
    }
    
    //table delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ns = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let classStr = data[indexPath.row]["class"]
        let Claz=NSClassFromString(ns + "." + classStr!) as! UIViewController.Type
        let VC:UIViewController=Claz.init()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
