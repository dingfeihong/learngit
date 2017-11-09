//
//  UserModel.swift
//  MyAlamofire
//
//  Created by Ding on 2017/9/1.
//  Copyright © 2017年 Ding. All rights reserved.
//

import Foundation
class UserModel: NSObject, NSCoding{
    private var m_id: String?
    private var m_pswd: String?
    
    func GetID() -> String{
        return m_id!
    }
    
    func GetPsd() -> String{
        return m_pswd!
    }
    
    
    required init(id:String="", pswd:String="") {
        self.m_id = id
        self.m_pswd = pswd
    }
    
    //从object解析回来
    required init(coder decoder: NSCoder) {
        self.m_id = decoder.decodeObject(forKey: "id") as? String ?? ""
        self.m_pswd = decoder.decodeObject(forKey: "password") as? String ?? ""
    }
    
    //编码成object
    func encode(with coder: NSCoder) {
        coder.encode(m_id, forKey:"id")
        coder.encode(m_pswd, forKey:"password")
    }
    
}

