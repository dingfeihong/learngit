//
//  UserModel.swift
//  MyAlamofire
//
//  Created by Ding on 2017/9/1.
//  Copyright © 2017年 Ding. All rights reserved.
//

import Foundation
class UserModel{
    private var m_name: String?
    private var m_id: String?
    private var m_pswd: String?
    private var m_status = false
    private var m_time: String?
    init(){
        
    }
    func load(name: String,pswd: String,id: String,status :Bool, time: String) {
        m_name = name
        m_pswd = pswd
        m_id = id
        m_status = status
        m_time = time
    }
    
    func GetStatus() -> Bool?{
        return m_status
    }
    func SetStatus(status: Bool){
        self.m_status = status
    }
    func GetID() -> String{
        return m_id!
    }
    func GetName() -> String{
        return m_name!
    }
    
    func GetTime() -> String{
        return m_time!
    }
    func SetTime(time: Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.m_time = formatter.string(from: time)
    }
}
