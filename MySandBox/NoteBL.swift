//
//  NoteBL.swift
//  MySandBox
//
//  Created by Ding on 2017/8/11.
//  Copyright © 2017年 Ding. All rights reserved.
//

import Foundation
class NoteBL {
    //保存数据列表
    var noteDAO: NoteDAO!
    private var dateFormatter = DateFormatter()

    static let sharedInstance: NoteBL = {
        let instance = NoteBL()
        instance.noteDAO = NoteDAO.sharedInstance
        instance.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return instance
    }()
    
    
    func getNum() -> Int {
        return noteDAO.getNum()
    }
    
    func showAll() -> NSMutableArray {
        let resultDataArr = noteDAO.findAll()
        return resultDataArr
    }
    func getCell(num:Int) -> NSDictionary{
        return noteDAO.getDict(num:num)
    }
    
    func insert(model:Note){
        let strDate = self.dateFormatter.string(from: model.date)
        noteDAO.insert(date:strDate, content:model.content)
    }
    //删除Note方法
    func remove(row: Int)  {
        noteDAO.remove(row: row)
    }
    //修改Note方法
    func modify(_ model: Note) -> Int {
        return 0
    }
    
    //修改Note方法
    func findById(_ model: Note) -> Note? {
        return nil
    }
    
}
