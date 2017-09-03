//
//  main.swift
//  test
//
//  Created by Ding on 2017/8/31.
//  Copyright © 2017年 Ding. All rights reserved.
//

import Foundation
import Alamofire
func startRequest() {
    
    let strURL = "http://cscw.fudan.edu.cn/CISWORK/login.html"
    let params = ["email": "test@51work6.com", "type": "JSON", "action": "query"]
    
    Alamofire.request(strURL, method: .get).responseJSON {
        response in
        guard let JSON = response.result.value else { return }
        print("JSON: \(JSON)")
    }
}
startRequest()
