//
//  ViewController.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/8/7.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit
import UserNotifications
/*
 cell view 生成方式
 1. built-in
 2. layoutSubviews 写在了subclass
 3. nib 同时给出了file owner
 4. sb 未测试
 
 访问cell 元素
 1. viewForTag 记得as!
 2. var name 变量名（built-in + custom）
 
 要注册与你对应类型的cell，有tableview来注册
 tb.dequeueReusableCell(withIdentifier: cellIdentifier) 返回？
 tb.dequeueReusableCell(withIdentifier: cellIdentifier for:indexPath)返回非nil
 非built-in记得as！
 */

class ViewController: UIViewController{
    
    let cellIdentifier="tbvCell"
    let headerViewIdentifier="tbvHeader"
    
    //table view title string
    var tableView:UITableView? = nil
    let cellTitle="title"
    let sectionTitle="sectionTitle"
    let cellData="class"
    let sectionData="sectionData"
    
    var data = NSMutableArray()
    var indexArr = ["KT","RN","NP","LA","UI","MX","CA","CG","Td","RT","Rl"]
    
    var hiddenSections:Set<Int> = []
    var hiddenDict = NSMutableDictionary()
    
    //searcher
    var searcher : UISearchController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="代码首页"
        
        //self.tableview
        let tb=UITableView.init(frame: UIScreen.main.bounds, style: .plain)
        self.tableView  = tb
        tb.tableFooterView=UIView(frame:.zero)
        tb.delegate=self
        tb.dataSource=self
        tb.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tb.register(UITableViewHeaderFooterView.self,
                    forHeaderFooterViewReuseIdentifier: headerViewIdentifier)
        tb.sectionIndexBackgroundColor = .clear

        self.view=tb
        
        data = VCTBData.data
        
       self.tableView?.refreshControl = VCTBRefreshControl.shared.refreshControl
        
        configSearchController()
        
        generateRightBarItem()
        
        //notificaiton demo
        generateUNUserNoftificaitonDemo()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //再次显示table view 时取消对table view 的选中效果
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView?.indexPathForSelectedRow
        {
            self.tableView?.deselectRow(at:index, animated: true)
        }
    }
    
    
    
    class VCTBRefreshControl {
        static let shared =   VCTBRefreshControl()
        public let refreshControl = UIRefreshControl()
        private init()
        {
            let r = refreshControl
            r.addTarget(self, action: #selector(doRefresh), for: .valueChanged)
            r.tintColor = .green
            r.attributedTitle = NSAttributedString(string:"过于简单建议用第三方框架")
        }
        
        @objc private  func doRefresh(_ sender: Any) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
                (sender as! UIRefreshControl).endRefreshing()
            }
        }
    }
    
   
    
    
    struct VCTBData{
       static var data:NSMutableArray{
        let LA = NSMutableArray()
        LA.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"指纹识别"),NSString(stringLiteral:"FingerRecognizerVC")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        LA.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"第三方键盘检测"),NSString(stringLiteral:"KeyBoradManagerVC")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        LA.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"本机推送设置"),NSString(stringLiteral:"NotificationSettingManagerVC")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        
        
        let UIKit = NSMutableArray()
        UIKit.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"MJRefreshTableView"),NSString(stringLiteral:"MJRefreshTableViewViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        UIKit.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"UIMenu弹出菜单"),NSString(stringLiteral:"UIMenuControllerVC")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        UIKit.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"Text ttf"),NSString(stringLiteral:"FontTTFViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        
        let Mix = NSMutableArray()
        Mix.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"Swift OC混编"),NSString(stringLiteral:"MixSwitWithOCVC")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        
        
        
        let CA = NSMutableArray()
        CA.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"BasicAnimatioin"),NSString(stringLiteral:"ViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        CA.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"AnimationProperty"),NSString(stringLiteral:"ViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        
        let CG = NSMutableArray()
        CG.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"RadialGradient"),NSString(stringLiteral:"RadialGradientViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        CG.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"CollectionView"),NSString(stringLiteral:"ViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        
        let Thread = NSMutableArray()
        Thread.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"Queue"),NSString(stringLiteral:"ViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        Thread.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"Thread"),NSString(stringLiteral:"ViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        
        let Runtime = NSMutableArray()
        Runtime.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"method swizzle and property "),NSString(stringLiteral:"RuntimePropertyListViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        
        Runtime.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"method propagate"),NSString(stringLiteral:"ViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        
        let Runloop = NSMutableArray()
        Runloop.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"Runloop"),NSString(stringLiteral:"RunloopViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        Runloop.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"RunloopLifeTime"),NSString(stringLiteral:"ViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        
        let BaseProject =  NSMutableArray()
        BaseProject.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"BaseProject"),NSString(stringLiteral:"BaseProjectViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        
        let RN =  NSMutableArray()
        RN.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"RN"),NSString(stringLiteral:"RNViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        
        let iOSKits =  NSMutableArray()
        iOSKits.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"Vison+CoreML"),NSString(stringLiteral:"VisionViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        
        iOSKits.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"Scroll+AutoLayout"),NSString(stringLiteral:"ScrollViewController")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
        
        
        let AllData=NSMutableArray()
        
        AllData.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"iOSKits"),iOSKits],
                forKeys: [NSString(stringLiteral:"sectionTitle"),NSString(stringLiteral:"sectionData")]))
        
        AllData.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"RN"),RN],
                forKeys: [NSString(stringLiteral:"sectionTitle"),NSString(stringLiteral:"sectionData")]))
        
        AllData.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"BaseProject"),BaseProject],
                forKeys: [NSString(stringLiteral:"sectionTitle"),NSString(stringLiteral:"sectionData")]))
        
        AllData.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"授权"),LA],
                forKeys: [NSString(stringLiteral:"sectionTitle"),NSString(stringLiteral:"sectionData")]))
        
        AllData.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"UIKit"),UIKit],
                forKeys: [NSString(stringLiteral:"sectionTitle"),NSString(stringLiteral:"sectionData")]))
        
        AllData.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"混合编程"),Mix],
                forKeys: [NSString(stringLiteral:"sectionTitle"),NSString(stringLiteral:"sectionData")]))
        
        AllData.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"CoreAnimation"),CA],
                forKeys: [NSString(stringLiteral:"sectionTitle"),NSString(stringLiteral:"sectionData")]))
        
        AllData.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"CoreGraphic"),CG],
                forKeys: [NSString(stringLiteral:"sectionTitle"),NSString(stringLiteral:"sectionData")]))
        
        AllData.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"MultiThread"),Thread],
                forKeys: [NSString(stringLiteral:"sectionTitle"),NSString(stringLiteral:"sectionData")]))
        
        AllData.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"Runtime"),Runtime],
                forKeys: [NSString(stringLiteral:"sectionTitle"),NSString(stringLiteral:"sectionData")]))
        
        AllData.add(
            NSDictionary(
                objects:
                [NSString(stringLiteral:"Runloop"),Runloop],
                forKeys: [NSString(stringLiteral:"sectionTitle"),NSString(stringLiteral:"sectionData")]))
        
        
        //    *   anoter way to make array
        //        let LA=[
        //            [cellTitle:"指纹识别",cellData:"FingerAuthorizationVC"],
        //            [cellTitle:"访问网络",cellData:"xxx"]
        //        ]
        //
        //
        //        let UIKit=[
        //            [cellTitle:"TableView",cellData:"xxx"],
        //            [cellTitle:"ColletionView",cellData:"xxx"]
        //        ]
        //
        //        let CA=[
        //            [cellTitle:"TableView",cellData:"xxx"],
        //            [cellTitle:"ColletionView",cellData:"xxx"]
        //        ]
        //
        //        let CG=[
        //            [cellTitle:"TableView",cellData:"xxx"],
        //            [cellTitle:"ColletionView",cellData:"xxx"]
        //        ]
        //
        //        let Thread=[
        //            [cellTitle:"TableView",cellData:"xxx"],
        //            [cellTitle:"ColletionView",cellData:"xxx"]
        //        ]
        //
        //        let Runtime=[
        //            [cellTitle:"TableView",cellData:"xxx"],
        //            [cellTitle:"ColletionView",cellData:"xxx"]
        //        ]
        //
        //        let Runloop=[
        //            [cellTitle:"TableView",cellData:"xxx"],
        //            [cellTitle:"ColletionView",cellData:"xxx"]
        //        ]
        //
        //       let data = NSMutableArray()
        //        data.add([sectionTitle:"授权",sectionData:LA])
        //        data.add([sectionTitle:"授权",sectionData:UIKit])
        //        data.add([sectionTitle:"动画",sectionData:CA])
        //        data.add([sectionTitle:"绘图",sectionData:CG])
        //        data.add([sectionTitle:"线程",sectionData:Thread])
        //        data.add([sectionTitle:"Runtime",sectionData:Runtime])
        //        data.add([sectionTitle:"Runloop",sectionData:Runloop])
        
        return AllData
        }
    }
}



// 导航栏右侧的bar item
extension ViewController
{
    func generateRightBarItem()
    {
        //inster delete modify
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                           target: self, action: #selector(doEdit))
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    
    //Navigation BarItem
    @objc func doEdit(_ sender: Any?) {
        var which : UIBarButtonSystemItem
        if !(self.tableView?.isEditing)! {
            self.tableView?.setEditing(true, animated:true)
            which = .done
        } else {
            self.tableView?.setEditing(false, animated:true)
            which = .edit
        }
        let b = UIBarButtonItem(barButtonSystemItem: which,
                                target: self, action: #selector(doEdit))
        self.navigationItem.rightBarButtonItem = b
    }
}

//search controller
extension ViewController:UISearchBarDelegate
{
    
    func configSearchController()
    {
        //search controller
        var filterData:[String]=[]
        for value in self.data {
            let v = value as! [String:Any]
            let innerArr = v[sectionData] as! [[String:String]]
            for  v in innerArr
            {
                filterData.append(v[cellData]!)
            }
        }
        
        let src = SearchResultsController(data: filterData)
        let searcher = UISearchController(searchResultsController: src)
        self.searcher = searcher
        searcher.searchResultsUpdater = src
        let b = searcher.searchBar
        b.delegate = self
        b.scopeButtonTitles = ["Starts", "Contains"]
        b.sizeToFit() // crucial, trust me on this one
        b.autocapitalizationType = .none
        
        self.tableView?.tableHeaderView = b
        self.tableView?.reloadData()
        self.tableView?.scrollToRow(
            at:IndexPath(row: 0, section: 0),
            at:.top, animated:false)
    }
    
    
    //UISearchbar delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.searcher?.searchResultsUpdater?.updateSearchResults(for: self.searcher!)
    }
}



//tableview datasouce delegate
extension ViewController:UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let h = tableView.dequeueReusableHeaderFooterView(
            withIdentifier:headerViewIdentifier)!
        if h.viewWithTag(1) == nil {
            //添加手势
            h.tag = section
            if h.gestureRecognizers == nil {
                let tap = UITapGestureRecognizer(
                    target: self, action: #selector(tapped))
                tap.numberOfTapsRequired = 2
                h.addGestureRecognizer(tap)
            }
            
            h.backgroundView = UIView()
            h.backgroundView?.backgroundColor = .lightGray
            let lab = UILabel()
            lab.tag = 1
            lab.font = UIFont(name:"Georgia-Bold", size:20)
            lab.textColor = .purple
            lab.backgroundColor = .clear
            h.contentView.addSubview(lab)
            let iv = UIImageView()
            iv.tag = 2
            iv.contentMode = .scaleAspectFit
            
            h.contentView.addSubview(iv)
            //constriant
            let dic = ["iv":iv,"lab":lab]
            iv.translatesAutoresizingMaskIntoConstraints = false
            lab.translatesAutoresizingMaskIntoConstraints = false
            var con=[NSLayoutConstraint]()
            con.append(iv.centerYAnchor.constraint(equalTo: h.contentView.centerYAnchor))
            con.append(iv.widthAnchor.constraint(equalTo: iv.heightAnchor))
            con.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "V:|[lab]|", metrics: nil, views: dic))
            con.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "V:|-3-[iv]-3-|", metrics: nil, views: dic))
            con.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lab]-15-[iv]-25-|", metrics: nil, views: dic))
            NSLayoutConstraint.activate(con)
        }
        let lab = h.contentView.viewWithTag(1) as! UILabel
        let sectionN = data.object(at: section) as! [String:Any]
        lab.text = (sectionN[sectionTitle] as! String)
        let iv = h.contentView.viewWithTag(2) as! UIImageView
        iv.image = UIImage(named:"monkey")
        return h
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 33
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = data.object(at: section) as! [String:Any]
        let cellArr = section[sectionData] as! NSArray
        return cellArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tb=self.view as! UITableView
        let cell=tb.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if cell.viewWithTag(1) == nil
        {
            cell.accessoryType = .disclosureIndicator
            let iv = UIImageView()
            iv.tag = 1
            cell.contentView.addSubview(iv)
            let lab = UILabel()
            lab.tag = 2
            cell.contentView.addSubview(lab)
            
            //autolayout
            let dic = ["iv":iv,"lab":lab]
            iv.translatesAutoresizingMaskIntoConstraints = false
            lab.translatesAutoresizingMaskIntoConstraints = false
            var con=[NSLayoutConstraint]()
            con.append(iv.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor))
            con.append(iv.widthAnchor.constraint(equalTo: iv.heightAnchor))
            con.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "V:|[lab]|", metrics: nil, views: dic))
            con.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lab]-15-[iv]-15-|", metrics: nil, views: dic))
            NSLayoutConstraint.activate(con)
            
            //添加手势显示menu
            let g = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(_:)))
            cell.addGestureRecognizer(g)
        }
        let iv = cell.viewWithTag(1) as! UIImageView
        let lab = cell.viewWithTag(2) as! UILabel
        
        let section = data.object(at: indexPath.section) as! [String:Any]
        
        let arr = section[sectionData] as! NSArray
        let dict = arr[indexPath.row] as! NSDictionary
        let title = dict[cellTitle] as! String
        
        iv.image = UIImage(named:"monkey")
        lab.text = title
        
        
        return cell
    }
    
    //显示在右侧的快速导航
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.indexArr
    }
    
    /*****      Cell删除      ******/
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let section = (self.data.object(at:indexPath.section)) as! NSDictionary
        let arr = section.object(forKey: NSString(stringLiteral:"sectionData")) as! NSMutableArray
        
        switch editingStyle {
            
        case .delete:
            arr.removeObject(at:indexPath.row)
            if arr.count == 0
            {
                self.data.removeObject(at: indexPath.section)
                self.indexArr.remove(at: indexPath.section)
                self.tableView?.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
            }else
            {
                self.tableView?.deleteRows(at: [indexPath], with: .automatic)
            }
            
            
            break
        case .insert:
            arr.add(NSDictionary(
                objects:
                [NSString(stringLiteral:"Added"),NSString(stringLiteral:"added")],
                forKeys: [NSString(stringLiteral:"title"),NSString(stringLiteral:"class")]))
            let ct = arr.count
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row:ct-1, section:indexPath.section)],
                                 with:.automatic)
            //加上这行有想左的动画，不加默认是向下添加
            //            tableView.reloadRows(at: [IndexPath(row:ct-2, section:indexPath.section)],
            //                                 with:.automatic)
            tableView.endUpdates()
            break
        default:
            print(" do nothing for UITableViewCellEditingStyle is .node")
        }
    }
    
    
    //放置不带有操作的行缩进
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section <= 1
        {
            return true
        }
        return false
    }
    
    //点击edit后指定TB的每个行的可操作性
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.section <= 1 {
            let ct = self.tableView(tableView, numberOfRowsInSection:indexPath.section)
            if ct-1 == indexPath.row {
                return .insert
            }
            return .delete;
        }
        return .none
    }
    
    //自定义Action Buttons
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let Mark = UITableViewRowAction(style:.normal,title:"Mark")
        {
            action,ip in
            print("Mark")
        }
        Mark.backgroundColor = .blue
        let Delete = UITableViewRowAction(style:.default,title:"Delete")
        {
            action,ip in
            self.tableView(self.tableView!, commit:.delete, forRowAt:ip)
        }
        return [Mark,Delete]
    }
    /*****     重新排序      ******/
    //rearrange table view
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let section = (self.data.object(at:indexPath.section)) as! NSDictionary
        let arr = section.object(forKey: NSString(stringLiteral:"sectionData")) as! NSMutableArray
        
        if indexPath.section == 2 && arr.count > 1
        {
            return true
        }
        
        return false
    }
    //控制目标indexPath
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        //这里不允许超出section
        if proposedDestinationIndexPath.section != 2 {
            return IndexPath(row:0, section:sourceIndexPath.section)
        }
        return proposedDestinationIndexPath
    }
    
    //真正的移动
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let section = (self.data.object(at:sourceIndexPath.section)) as! NSDictionary
        let arr = section.object(forKey: NSString(stringLiteral:"sectionData")) as! NSMutableArray
        let obj = arr.object(at: sourceIndexPath.row)
        arr.removeObject(at: sourceIndexPath.row)
        arr.insert(obj, at: destinationIndexPath.row)
        
        self.tableView?.reloadData()
    }
    
    /*****    Dynamic Cells    *****/
    @objc func tapped (_ g : UIGestureRecognizer) {
        let v = g.view as! UITableViewHeaderFooterView
        let sec = v.tag
        let section = (self.data.object(at:sec)) as! NSDictionary
        let cellArr = section.object(forKey: NSString(stringLiteral:"sectionData")) as! NSMutableArray
        
        
        if self.hiddenSections.contains(sec) {
            let innerArr = hiddenDict.object(forKey: NSNumber( value:sec)) as! NSArray
            cellArr.addObjects(from: innerArr.mutableCopy() as! [Any])
            let ct = cellArr.count
            let arr = (0..<ct).map {IndexPath(row:$0, section:sec)}
            hiddenDict.removeObject(forKey: NSNumber( value:sec))
            self.hiddenSections.remove(sec)
            self.tableView?.beginUpdates()
            self.tableView?.insertRows(at:arr, with:.automatic)
            self.tableView?.endUpdates()
            //保证当超过屏幕的时候保证视觉可见
            self.tableView?.scrollToRow(at:arr[ct-1], at:.none, animated:true)
        } else {
            let ct = cellArr.count
            let arr = (0..<ct).map {IndexPath(row:$0, section:sec)}
            self.hiddenSections.insert(sec)
            hiddenDict.setObject(cellArr.mutableCopy(), forKey: NSNumber( value:sec))
            cellArr.removeAllObjects()
            self.hiddenSections.insert(sec)
            self.tableView?.beginUpdates()
            self.tableView?.deleteRows(at:arr, with:.automatic)
            self.tableView?.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = data.object(at: indexPath.section) as! [String:Any]
        
        let arr = section[sectionData] as! NSArray
        let dict = arr[indexPath.row] as! NSDictionary
        let classStr = dict[cellData] as! String
        let ns = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let Claz=NSClassFromString(ns + "."+classStr) as! UIViewController.Type
        let VC:UIViewController=Claz.init()
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

//table view cell long press
extension ViewController
{
    //menuitem需要在有editext的时候弹出，所以此处无法弹出
    @objc func longPressGesture(_ g : UIGestureRecognizer)
    {
        if g.state == .began
        {
            print("long press")
            let cell = g.view as! UITableViewCell
            cell.becomeFirstResponder()
            let ip = self.tableView?.indexPath(for: cell)
            print("indexpath: row \(ip?.row ?? -1)")
            let menu = UIMenuController.shared
            var cellRect = self.tableView?.rectForRow(at: ip!)
            cellRect?.origin.y += 40
            let deleteItem = UIMenuItem(title: "Delete", action:  #selector(ViewController.deleteFun))
            let editItems = UIMenuItem(title: "Edit", action: #selector(ViewController.editFun))
            menu.menuItems = [deleteItem ,editItems]
            
            menu.setTargetRect(cellRect!, in: self.view!)
            menu.setMenuVisible(true, animated: true)
        }
        
    }
    
    @objc func deleteFun(_ sender:UIMenuItem)
    {
        print("delete")
    }
    @objc func editFun(_ sender:UIMenuItem)
    {
        print("edit")
    }
}

//notification generate demo
extension ViewController{
    func generateUNUserNoftificaitonDemo()
    {
        let action1 = UNNotificationAction.init(identifier: "action1_identifier", title: "action1_title", options: UNNotificationActionOptions.init(rawValue: 0)
        )
        
        let action2 = UNNotificationAction.init(identifier: "action2_identifier", title: "action2_title", options: UNNotificationActionOptions.foreground)
        let textInputAction = UNTextInputNotificationAction.init(identifier: "input text", title: "input text title", options: UNNotificationActionOptions.foreground)
        let category = UNNotificationCategory(identifier: "message", actions: [action1,textInputAction,action2], intentIdentifiers: [], options: UNNotificationCategoryOptions.customDismissAction)
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        
        let content = UNMutableNotificationContent()
        content.title = "content itle"
        content.subtitle = "content subtitle"
        content.body = "content body"
        content.badge = 1
        content.categoryIdentifier = "message"
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 10, repeats: false)
        
        let requestIdentifier = "requestIdentifier"
        let request = UNNotificationRequest.init(identifier: requestIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let e = error
            {
                print(e)
            }
        }
        
        
    }
}




