//
//  NoteDao.swift
//  MyNote
//
//  Created by Ding on 2017/8/7.
//  Copyright © 2017年 Ding. All rights reserved.
//

import Foundation

class NoteDAO {
    //保存数据列表
    var sqlHelper: SQLiteHelper!
    static let sharedInstance: NoteDAO = {
        
        let instance = NoteDAO()
        instance.sqlHelper = SQLiteHelper.shareInstance()!
        return instance
    }()
    
    
    func showAll() -> [Any]? {
        let resultDataArr = sqlHelper.queryDataBase()
        return resultDataArr
    }
    /*func insert(date: Date?, context: String?){
       /// let idNumText : String = idNum.text!
        ///let stuNameText : String = stuName.text!
        let insertSQL = "INSERT INTO note (stuNum, stuName) VALUES (?, ?);"
        
        
        sqlite3_bind_text(statement, 1, strDate!, -1, nil)
        sqlite3_bind_text(statement, 2, content!, -1, nil)
        if sqlHelper.execSQL(sql: insertSQL) != true {
            print("插入数据失败")
        }
    }*/
    
    func insert(model:Note){
        sqlHelper.insert(date: model.date,content: model.content)
    }
    //删除Note方法
    func remove(_ model: Note) -> Int {
        
        return 0
    }
        //修改Note方法
    func modify(_ model: Note) -> Int {
               return 0
    }
    
    //查询所有数据方法
    func findAll() -> NSMutableArray? {
       return nil
    }
    
    //修改Note方法
    func findById(_ model: Note) -> Note? {
        return nil
    }
   
}
