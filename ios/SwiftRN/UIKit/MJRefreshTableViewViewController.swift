//
//  MJRefreshTableViewViewController.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/11/16.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit
import MJRefresh

class MJRefreshTableViewViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var tableView:UITableView? = nil
    let cellIdentifier="nsipTBCell"
    var data:[String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.data = Array(repeating: "demo数据", count: 20)
        
        self.title="MJRefresh Demo"
        let tb=UITableView.init(frame: UIScreen.main.bounds, style: .plain)
        self.tableView  = tb
        tb.tableFooterView=UIView(frame:.zero)
        
        tb.delegate=self
        tb.dataSource=self
        tb.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view=tb
        
         let header = MJRefreshNormalHeader.init {
          
            print("refreshing...")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
                (self.view as! UITableView).mj_header.endRefreshing()
            })
            
        }
        tb.mj_header = header
       
    }
    
    //table view datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    //table delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //do nothing
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
