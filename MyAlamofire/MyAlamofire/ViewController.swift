//
//  ViewController.swift
//  MyAlamofire
//
//  Created by Ding on 2017/9/1.
//  Copyright © 2017年 Ding. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
class ViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    private let webBL = WebBL.sharedInstance
    var model: UserModel = UserModel()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //NotificationCenter.default.addObserver(self, selector: "signIn", name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
    }

    @IBAction func Quit(_ sender: Any) {
        exit(0)
    }
    @IBAction func LogIn(_ sender: Any) {
        let url = "http://cscw.fudan.edu.cn/CISWORK/WebService.asmx/IsValiad"
        let params =  ["uname": userName.text!, "pwd":passWord.text!]
      //  let params =  [ "type": "JSON", "action": "query"]
        
        Alamofire.request(url, method: .get,parameters: params).responseString {
            response in
            guard let logStr = response.result.value else { return }
            //判断在字符串a中是否包含"Hello"字符串
            
            if(logStr.contains("true")){
                print("Login successful")
                self.performSegue(withIdentifier:"login", sender: self)
            }
            
            //self.model.load(name: self.userName.text!, pswd: self.passWord.text!, id: id, status: sign, time: time)
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login"{
            let controller = segue.destination as! SignInController
            //controller.m_model = self.model
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

