//
//  OnlineViewController.swift
//  CISLSign
//
//  Created by Ding on 2017/10/19.
//  Copyright © 2017年 Ding. All rights reserved.
//

import UIKit
import Alamofire
class OnlineViewController: UITableViewController{
    var listData:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Queryonline()
    }
    
    func Queryonline() {
        let url = "http://cscw.fudan.edu.cn/CISWORK/WebService.asmx/GetSearch"
        Alamofire.request(url, method: .get).responsePropertyList {
            response in
            guard let onlineStr = response.result.value else { return }
            
            let res = onlineStr as! String
            let data = res.data(using: String.Encoding.utf8)
            
            let jsonArr = try! JSONSerialization.jsonObject(with: data!,options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
            print("记录数：\(jsonArr.count)")
            for json in jsonArr {
                let dict = NSDictionary(objects: [json["userId"]!,json["zh_name"]!,json["signTimestamp"]!], forKeys: ["ID" as NSCopying,"Name" as NSCopying,"Date" as NSCopying])
                self.listData.adding(dict)
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        let row = indexPath.row
        if self.listData.count > 0 {
            let rowDict = self.listData[row] as! NSDictionary
            cell.textLabel?.text = rowDict["zh_name"] as? String
            
            cell.detailTextLabel?.text = rowDict["signTimestamp"] as! String
        }
        return cell
    }

}
