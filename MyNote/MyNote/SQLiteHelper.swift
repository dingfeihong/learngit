//
//  SQLiteHelper.swift
//  MyNote
//
//  Created by Ding on 2017/8/7.
//  Copyright © 2017年 Ding. All rights reserved.
//

import UIKit
import Foundation
class SQLiteHelper: NSObject {
    //数据库实例
    fileprivate var db : OpaquePointer? = nil
    //数据库路径
    let DBFILE_NAME = "DataBase.sqlite"
    //私有DateFormatter属性
    fileprivate var dateFormatter = DateFormatter()
    
   
    //单例模式
    open static func shareInstance() -> SQLiteHelper?{
        //初始化单例
        let instance = SQLiteHelper()
        //初始化DateFormatter
        instance.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if !(instance.openDatabase()&&instance.creatTable())
        {
            
            sqlite3_close(instance.db)
            return nil
        }
        
        sqlite3_close(instance.db)
        return instance
    }
    
    
    func openDatabase() -> Bool{
        
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        let DBPath = (documentPath! as NSString).appendingPathComponent(DBFILE_NAME)
        let path = DBPath.cString(using: String.Encoding.utf8)
        
        if sqlite3_open(path, &db) != SQLITE_OK{
            NSLog("数据库打开失败")
            return false;
        }
        
        
       
            let fileManager = FileManager.default
            do{
                try fileManager.copyItem(atPath: DBPath, toPath: "/Users/Ding/Desktop/Project/swift/database.sqlite")
            }catch{
                assert(false,"写入错误")
        }
        
        return true
    }
    
    
    private func creatTable() -> Bool{
        let sql = "CREATE TABLE IF NOT EXISTS Note (cdate TEXT PRIMARY KEY, content TEXT)"
        
        return execSQL(sql: sql)
    }
    
    func execSQL(sql: String) -> Bool
    {
        // 0.将Swift字符串转换为C语言字符串
        let cSQL = sql.cString(using: String.Encoding.utf8)!
        let a=sqlite3_exec(db, cSQL, nil, nil, nil)
        if a != SQLITE_OK
        {
            return false
        }
        return true

    }
    
    open func insert(date:Date,content: String){
        if !openDatabase(){
           return
        }
        //sql语句
        let tmp = "INSERT OR REPLACE INTO note (cdate, content) VALUES (?,?)"
        let sql = tmp.cString(using: String.Encoding.utf8)
        //语句对象
        var statement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, sql!, -1, &statement, nil) == SQLITE_OK{
            let strDate = self.dateFormatter.string(from: date as Date).cString(using: String.Encoding.utf8)
            let content = content.cString(using: String.Encoding.utf8)
            //绑定参数开始
            sqlite3_bind_text(statement, 1, strDate!, -1, nil)
            sqlite3_bind_text(statement, 2, content!, -1, nil)
            //执行插入
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog("插入数据失败。")
            }
              sqlite3_finalize(statement)
        }
        sqlite3_close(db)
    }
    func queryDataBase() -> [String]?{
        let sql = "SELECT cdate, content FROM Note"
        var noteArr = [String]()
        if !openDatabase(){
            return nil
        }
        var statement : OpaquePointer? = nil
        if sql.lengthOfBytes(using: String.Encoding.utf8) < 0{
            return nil
        }
        
        let cQuerySQL = (sql.cString(using: String.Encoding.utf8))!
        // 进行查询前的准备工作
        // 第一个参数：数据库对象，第二个参数：查询语句，第三个参数：查询语句的长度（如果是全部的话就写-1），第四个参数是：句柄（游标对象）
        if sqlite3_prepare_v2(db, cQuerySQL, -1, &statement, nil) != SQLITE_OK {
            return nil
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            // 获取解析到的列
            let columnCount = sqlite3_column_count(statement)
            
            for i in 0..<columnCount {
                // 取出i位置列的字段名
                let bufDate = sqlite3_column_name(statement, i)
                let strDate : String = String(validatingUTF8: bufDate!)!
                //noteArr.append(strDate)
                //取出i位置存储的值
                let bufContent = sqlite3_column_text(statement, i)
                let content = String(cString: bufContent!)
                noteArr.append(content)
            }
        }
        return noteArr
        
    }
}
