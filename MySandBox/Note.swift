//
//  Note.swift
//  MyNote
//
//  Created by Ding on 2017/8/7.
//  Copyright © 2017年 Ding. All rights reserved.
//

import Foundation
open class Note: NSObject, NSCoding {
    
    open var date: Date
    open var content: String
    
    //私有DateFormatter属性
  //  fileprivate var dateFormatter = DateFormatter()
    

    public init(date: Date, content: String) {
        self.date = date
        self.content = content
        
       // dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    override public init() {
        self.date = Date()
        self.content = ""
    }
    
    // MARK: --实现NSCoding协议
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(content, forKey: "content")
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.date = aDecoder.decodeObject(forKey: "date") as! Date
        self.content = aDecoder.decodeObject(forKey: "content") as! String
    }
}
