//
//  SearchResultsController.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/8/17.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit

let cellIdentifier = "Cell"
class SearchResultsController: UITableViewController,UISearchResultsUpdating {

    var originalData:[String]
    var filteredData:[String]
    init(data:[String]) {
        self.originalData = data.flatMap{$0}
        self.filteredData = []
        super.init(style:.plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        
        self.tableView.tableFooterView=UIView(frame:.zero)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.filteredData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier:cellIdentifier, for: indexPath)
        cell.textLabel!.text = self.filteredData[indexPath.row]
        if cell.gestureRecognizers == nil
        {
           //添加手势
        }
        return cell
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //UISearchResultUpdating Protocol
    func updateSearchResults(for searchController: UISearchController) {
        let sb = searchController.searchBar
        let target = sb.text!
        self.filteredData = self.originalData.filter { s in
        var options = String.CompareOptions.caseInsensitive
        // we now have scope buttons; 0 means "starts with"
            if searchController.searchBar.selectedScopeButtonIndex == 0 {
                options.insert(.anchored)
            }
            let found = s.range(of:target, options: options)
            return (found != nil)
        }
        self.tableView.reloadData()
    }
    
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return true
    }
    
}
