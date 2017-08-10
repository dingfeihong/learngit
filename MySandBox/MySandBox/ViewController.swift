//
//  ViewController.swift
//  MySandBox
//
//  Created by Ding on 2017/8/10.
//  Copyright © 2017年 Ding. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    
    var dictData = [Any]()
    var note: NoteDAO!
    private var n = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        note = NoteDAO.sharedInstance
        
        dictData = note.showAll()!
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func click(_ sender: Any) {
        let date = Date()
        let new = Note(date: date, content: "\(n)")
        note.insert(model: new)
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

