//
//  ArchiverDAO.swift
//  MySandBox
//
//  Created by Ding on 2017/8/15.
//  Copyright © 2017年 Ding. All rights reserved.
//

import Foundation
class ArchiverDAO
{
    //私有的DateFormatter属性
    
    private var plistFilePath:String?
    private var array:NSMutableArray?
    public static let sharedInstance: NoteDAO = {
        let instance = NoteDAO()
        instance.initSandBox()
        //初始化属性列表文件
        
        
        return instance
    }()
    func initSandBox(){
        self.plistFilePath = self.applicationDocumentsDirectoryFile()
        let fileManager = FileManager.default
        let exits = fileManager.fileExists(atPath: self.plistFilePath!)
        if (!exits){
            let myData = NSMutableData()
            let archiver = NSKeyedArchiver(forWritingWith: myData)
            archiver.finishEncoding()
            myData.write(toFile: self.plistFilePath!, atomically: true)
        }
    }
    
    func applicationDocumentsDirectoryFile() -> String {
        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let path = (documentDirectory[0] as AnyObject).appendingPathComponent("NotesList.plist") as String
        return path
    }
    
    public func insert(model:Note){
  
        array!.add(model)

        NSKeyedArchiver.archiveRootObject(array!, toFile:self.plistFilePath!)
        
    }
    func getDict(num:Int) -> NSDictionary{
        return array![num] as! NSDictionary
    }
    public func getNum() -> Int{
        return array!.count
    }
    public func remove(row:Int){
        let dict = array![row] as! NSDictionary
        let delDate = dict["date"] as! String
        
        for item in array!{
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            if strDate == delDate{
                array!.remove(dict)
                array!.write(toFile: self.plistFilePath!, atomically: true)
            }
        }
    }
    
    public func findAll() -> NSMutableArray{
        let myData = NSMutableData(contentsOfFile: self.plistFilePath!)
        if (myData?.length)! > 0{
            let archiver = NSKeyedArchiver(forWritingWith: myData!)
            array = archiver.decodeObject(forKey: ) as! NSMutableArray
            
            
        }
    }
}
