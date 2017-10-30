//
//  OnlineViewController.swift
//  CISLSign
//
//  Created by Ding on 2017/10/19.
//  Copyright © 2017年 Ding. All rights reserved.
//

import UIKit
import Alamofire
class OnlineViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    var listData =  NSMutableArray()//在线人数数据
    @IBOutlet var tableView: UITableView!
    
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        //查询在线人数
        Queryonline()
        
        tableView.reloadData()
    }
    
    func Queryonline() {
        
        //向该地址发送查询post 命令
        let url = "http://cscw.fudan.edu.cn/CISWORK/WebService.asmx/GetSearch"
        Alamofire.request(url, method: .get).responsePropertyList {
            response in
            guard let onlineStr = response.result.value else { return }
            
            //转换为json
            let res = onlineStr as! String
            let data = res.data(using: String.Encoding.utf8)
            let jsonArr = try! JSONSerialization.jsonObject(with: data!,options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
            print("记录数：\(jsonArr.count)")
            
            //遍历加入listData
            for json in jsonArr {
                let dict = NSDictionary(objects: [json["zhName"]!,json["recordTime"]!], forKeys: ["Name" as NSCopying,"Date" as NSCopying])
                self.listData.add(dict)
            }
            self.tableView.reloadData()
        }
    }
    @IBAction func Back(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        let row = indexPath.row//当前第几列
        
        if self.listData.count > 0 {
            let rowDict = self.listData[row] as! NSDictionary
            cell.textLabel?.text = rowDict["Name"] as? String
            cell.detailTextLabel?.text = "签入时间:" + (rowDict["Date"] as? String)!
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
}

