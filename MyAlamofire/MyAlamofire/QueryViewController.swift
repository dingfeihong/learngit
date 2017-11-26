//
//  QueryViewController.swift
//  CISLSign
//
//  Created by Ding on 2017/10/30.
//  Copyright © 2017年 Ding. All rights reserved.
//

import UIKit

import Alamofire
class QueryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
   
    //时间选择
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    
    //在线人数数据
    var listData:NSMutableArray?
    @IBOutlet var tableView: UITableView!
    
    //拉刷新控制器
    var refreshControl = UIRefreshControl()
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        startButton.setTitle(dateFormatter.string(from: startOfCurrentMonth()), for: UIControlState.normal)
        startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        endButton.setTitle(dateFormatter.string(from: endOfCurrentMonth()), for: UIControlState.normal)
        endButton.titleLabel?.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
        Queryonline()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //返回
    @IBAction func Back(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    //本月第一天日期
    func startOfCurrentMonth() -> Date {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)
        return startOfMonth!
    }
    
    //本月结束日期
    func endOfCurrentMonth(returnEndTime:Bool = false) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        let endOfMonth =  calendar.date(byAdding: components , to: startOfCurrentMonth())
        return endOfMonth!
    }

    @IBAction func StartTime(_ sender: Any) {
        let mybutton=sender as? UIButton
        let alertController:UIAlertController=UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        // 初始化 datePicker
        let datePicker = UIDatePicker( )
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = NSLocale(localeIdentifier: "zh_CN") as Locale
        // 设置样式，当前设为同时显示日期和时间
        datePicker.datePickerMode = UIDatePickerMode.date
        // 设置默认时间
        datePicker.date = NSDate() as Date
        // 响应事件（只要滚轮变化就会触发）
        // datePicker.addTarget(self, action:Selector("datePickerValueChange:"), forControlEvents: UIControlEvents.ValueChanged)
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default){
            (alertAction)->Void in
            print("date select: \(datePicker.date.description)")
            mybutton?.setTitle(self.dateFormatter.string(from: datePicker.date), for: UIControlState.normal)
            self.Queryonline()
        })
        
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler:nil))
        alertController.view.addSubview(datePicker)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        let row = indexPath.row//当前第几列
        
        if self.listData!.count > 0 {
            let rowDict = self.listData![row] as! NSDictionary
            cell.textLabel?.text = (rowDict["Name"] as? String)!
            
            var tmp = "上午坐班次数:" + (rowDict["BusinessTime"] as? String)!
            tmp += "\n工作时间:"+(rowDict["WorkTime"] as? String)! + " 总时间:"+(rowDict["TotalTime"] as? String)!
            cell.detailTextLabel?.numberOfLines = 2
            cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.detailTextLabel?.text = tmp
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func Queryonline() {
        listData =  NSMutableArray()
        //向该地址发送查询post 命令
        let url = "http://cscw.fudan.edu.cn/CISWORK/WebService.asmx/GetStatistics"
        let params =  ["begin": startButton.title(for: UIControlState.normal)!, "end":endButton.title(for: UIControlState.normal)!]//登录参数
        Alamofire.request(url, method: .get, parameters: params).responsePropertyList {
            response in
            guard let onlineStr = response.result.value else { return }
            
            //转换为json
            let res = onlineStr as! String
            let data = res.data(using: String.Encoding.utf8)
            let jsonArr = try! JSONSerialization.jsonObject(with: data!,options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
            print("记录数：\(jsonArr.count)")
            
            //遍历加入listData
            for json in jsonArr {
                let dict = NSDictionary(objects: [json["zhName"]!,json["businessTime"]!,json["workTime"]!,json["totalTime"]!], forKeys: ["Name" as NSCopying,"BusinessTime" as NSCopying,"WorkTime" as NSCopying,"TotalTime" as NSCopying])
                self.listData!.add(dict)
            }
            self.tableView.reloadData()
        }
    }

}
