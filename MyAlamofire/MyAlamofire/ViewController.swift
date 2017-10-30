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
    
    @IBOutlet weak var userName: UITextField!//登录名
    @IBOutlet weak var passWord: UITextField!//登录密码
    //private let webBL = WebBL.sharedInstance
    //var model: UserModel = UserModel()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //NotificationCenter.default.addObserver(self, selector: "signIn", name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
    }

    //退出
    @IBAction func Quit(_ sender: Any) {
        exit(0)
    }
    
    //登陆
    @IBAction func LogIn(_ sender: Any) {
        
        let url = "http://cscw.fudan.edu.cn/CISWORK/WebService.asmx/IsValiad"//登陆接口地址
        let params =  ["uname": userName.text!, "pwd":passWord.text!]//登录参数
        
        Alamofire.request(url, method: .get,parameters: params).responseString {
            response in
            guard let logStr = response.result.value else { return }
            
            //判断在字符串logStr中是否包含"true"字符串
            if(logStr.contains("true")){
                //登录成功
                print("Login successful")
                self.performSegue(withIdentifier:"login", sender: self)
            }
            
            //self.model.load(name: self.userName.text!, pswd: self.passWord.text!, id: id, status: sign, time: time)
        }

    }
    
    //参数传递，当segue是login
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login"{
            let controller = segue.destination as! UITabBarController//SignInController
            //controller.m_model = self.model
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

