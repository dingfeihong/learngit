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
    let userDefault = UserDefaults.standard
    override func viewDidLoad() {
        
        guard let UserModel = self.get_model() else { super.viewDidLoad(); return }
        
        super.viewDidLoad()
        userName.text = UserModel.GetID()
        passWord.text = UserModel.GetPsd()
    }

    //退出
    @IBAction func Quit(_ sender: Any) {
        exit(0)
    }
    
    @IBOutlet weak var errSign: UILabel!
    //登陆
    @IBAction func LogIn(_ sender: Any) {
        
        let url = "http://cscw.fudan.edu.cn/CISWORK/WebService.asmx/IsValiad"//登陆接口地址
        let params =  ["uname": userName.text!, "pwd":passWord.text!]//登录参数
        
        Alamofire.request(url, method: .get,parameters: params).responseString {
            response in
            guard let logStr = response.result.value else {return}
            
            let model = UserModel(id:self.userName.text!, pswd:self.passWord.text!)
            //实例对象转换成Data
            let modelData = NSKeyedArchiver.archivedData(withRootObject: model)
            //存储Data对象
            self.userDefault.set(modelData, forKey: "myModel")
            
            
            //判断在字符串logStr中是否包含"true"字符串
            if(logStr.contains("true")){
                //登录成功
                print("Login successful")
                self.errSign.text = " "
                self.performSegue(withIdentifier:"login", sender: self)
            }
            else{
                 self.errSign.text = "登录失败，请检查用户名密码"
            }
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

    func get_model() -> UserModel?{
   
        let myModelData =  self.userDefault.data(forKey: "myModel")
        
        if(myModelData != nil){
            let myModel = NSKeyedUnarchiver.unarchiveObject(with: myModelData!) as! UserModel
            return myModel
        }else{
            return nil
        }
    }


}
