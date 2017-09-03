//
//  WebDAO.swift
//  MyAlamofire
//
//  Created by Ding on 2017/9/1.
//  Copyright © 2017年 Ding. All rights reserved.
//

import Foundation
import Alamofire

class WebDAO{
    dynamic var res: Any? = nil
    static let sharedInstance: WebDAO = {
        let instance = WebDAO()
        return instance
    }()
    
    func startRequest(strURL:String ,params:[String:String],meth: HTTPMethod) {
        
        Alamofire.request(strURL, method: .get, parameters: params).responseJSON {
            response in
            guard let JSON = response.result.value else { return }
            print("JSON: \(JSON)")
            self.res = JSON
        }
    }
    
}
