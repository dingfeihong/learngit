//
//  NoteDao.swift
//  MyNote
//
//  Created by Ding on 2017/8/7.
//  Copyright © 2017年 Ding. All rights reserved.
//

import Foundation


open class NoteDAO {
    
    //私有的DateFormatter属性
    fileprivate var dateFormatter = DateFormatter()
    //私有的沙箱目录中属性列表文件路径
    fileprivate var plistFilePath: String!
    
    open static let sharedInstance: NoteDAO = {
        let instance = NoteDAO()
        
        //初始化沙箱目录中属性列表文件路径
        instance.plistFilePath = instance.applicationDocumentsDirectoryFile()
        //初始化DateFormatter
        instance.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //初始化属性列表文件
        instance.createEditableCopyOfDatabaseIfNeeded()
        
        return instance
    }()
    
    //初始化属性列表文件
    func createEditableCopyOfDatabaseIfNeeded() {
        
        let fileManager = FileManager.default
        let dbexits = fileManager.fileExists(atPath: self.plistFilePath)
        if (!dbexits) {
            
            let frameworkBundle = Bundle(for: NoteDAO.self)
            let frameworkBundlePath = frameworkBundle.resourcePath as NSString?
            let defaultDBPath = frameworkBundlePath!.appendingPathComponent("NotesList.plist")
            
            do {
                try fileManager.copyItem(atPath: defaultDBPath, toPath: self.plistFilePath)
            } catch {
                let nserror = error as NSError
                NSLog("数据保存错误：%@", nserror.localizedDescription)
                assert(false, "错误写入文件")
            }
        }
    }
    
    func applicationDocumentsDirectoryFile() -> String {
        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let path = (documentDirectory[0] as AnyObject).appendingPathComponent("NotesList.plist") as String
        return path
    }
    
    //插入Note方法
    open func create(_ model: Note) -> Int {
        
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        let strDate = self.dateFormatter.string(from: model.date as Date)
        let dict = NSDictionary(objects: [strDate, model.content], forKeys: ["date" as NSCopying, "content" as NSCopying])
        
        array.add(dict)
        
        array.write(toFile: self.plistFilePath, atomically: true)
        
        return 0
    }
    
    //删除Note方法
    open func remove(_ model: Note) -> Int {
        
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        
        for item in array {
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)
            
            //比较日期主键是否相等
            if date! == model.date as Date {
                array.remove(dict)
                array.write(toFile: self.plistFilePath, atomically: true)
                break
            }
        }
        return 0
    }
    
    //修改Note方法
    open func modify(_ model: Note) -> Int {
        
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        
        for item in array {
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)
            
            //比较日期主键是否相等
            if date! == model.date as Date {
                dict.setValue(model.content, forKey: "content")
                array.write(toFile: self.plistFilePath, atomically: true)
                break
            }
        }
        return 0
    }
    //查询所有数据方法
    open func findAll() -> NSMutableArray {
        
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        
        let listData = NSMutableArray()
        
        for item in array {
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)!
            let content = dict["content"] as! String
            
            let note = Note(date: date, content: content)
            
            listData.add(note)
        }
        
        return listData
    }
    
    //按照主键查询数据方法
    open func findById(_ model: Note) -> Note? {
        
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        
        for item in array {
            
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)!
            let content = dict["content"] as! String
            
            //比较日期主键是否相等
            if date == model.date as Date {
                let note = Note(date: date, content: content)
                return note
            }
        }
        return nil
    }
    
    
}
