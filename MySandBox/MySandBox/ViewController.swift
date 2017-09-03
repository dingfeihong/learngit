//
//  ViewController.swift
//  MySandBox
//
//  Created by Ding on 2017/8/10.
//  Copyright © 2017年 Ding. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    
    var noteBL: NoteBL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteBL = NoteBL.sharedInstance
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteBL.getNum()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // 给cell赋值
        if noteBL.getNum() > 0 {
            let dict = noteBL.getCell(num: indexPath.row)
            cell.textLabel?.text = (dict["date"] as! String)
            cell.detailTextLabel?.text = (dict["content"] as! String)
        }
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()

    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            noteBL.remove(row: indexPath.row)
            tableView.reloadData()
        }
        
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

}

