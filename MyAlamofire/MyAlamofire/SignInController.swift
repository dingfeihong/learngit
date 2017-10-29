//
//  SignInController.swift
//  MyAlamofire
//
//  Created by Ding on 2017/9/2.
//  Copyright © 2017年 Ding. All rights reserved.
//

import UIKit
import Alamofire
class SignInController: UIViewController {


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
                print("ID：", json["userId"]!, "  Name：", json["zh_name"]!, "  Time：", json["signTimestamp"]!)
            }
        }
    }
    @IBAction func Back(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func StartThread(_ sender: Any) {
        
    }
    
    
    
}

