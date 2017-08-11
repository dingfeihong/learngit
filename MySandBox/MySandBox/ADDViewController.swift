//
//  ADDViewController.swift
//  MySandBox
//
//  Created by Ding on 2017/8/11.
//  Copyright © 2017年 Ding. All rights reserved.
//

import UIKit

class ADDViewController: UIViewController {
    @IBOutlet weak var content: UITextField!
    
    var noteBL: NoteBL!
    override func viewDidLoad() {
        super.viewDidLoad()
        noteBL = NoteBL.sharedInstance
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func BackToView(_ sender: Any) {
        self.dismiss(animated: true,completion: {
            NSLog("返回")
        })
    }
    @IBAction func click(_ sender: Any) {
        let date = Date()
        if(content.text != "")
        {
            let new = Note(date: date, content: content.text!)
            noteBL.insert(model: new)
        }
        self.dismiss(animated: true,completion: {
            NSLog("返回")
        })
    }
}
