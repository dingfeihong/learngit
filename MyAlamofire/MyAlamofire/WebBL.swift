//
//  WebBL.swift
//  MyAlamofire
//
//  Created by Ding on 2017/9/1.
//  Copyright © 2017年 Ding. All rights reserved.
//
//

import UIKit
import Foundation
import Alamofire
class WebBL{
    var model: UserModel = UserModel()
    let dao = WebDAO.sharedInstance
    
    static let sharedInstance: WebBL = {
        let instance = WebBL()
        return instance
    }()
    func SignIn(name:String,pswd:String){
        let url = "http://10.131.200.20/CISWORK/php/getStatusForWin.php"
        let params =  ["username": name, "password":pswd, "type": "JSON", "action": "query"]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON {
            response in
            guard let JSON = response.result.value else { return }
            let res = JSON as! NSDictionary
            let id = res.value(forKey: "userid") as! String
            let time = res.value(forKey: "signtime") as! String
            let sign = (res.value(forKey: "signflag") as! String) == "1" ? true:false
            
            self.model.load(name: name, pswd: pswd, id: id, status: sign ,time: time)
            print("JSON: \(JSON)")
        }

       
    }
}
