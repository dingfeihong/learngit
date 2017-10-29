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
    
    var dictData = [Any]()
    //var note: NoteDAO!
    override func viewDidLoad() {
        super.viewDidLoad()
       // note = NoteDAO.sharedInstance
        
        //   note.insert(date: nil, context: nil)
        //dictData = note.showAll()!
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictData.count/2
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // 给cell赋值
        if self.dictData.count > 0 {
            cell.textLabel?.text = (dictData[indexPath.row*2] as! String)
            cell.detailTextLabel?.text = (dictData[indexPath.row*2+1] as! String)
        }
        return cell
    }

}
