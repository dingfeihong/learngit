//
//  NoteDAO.swift
//  MySandBox
//
//  Created by Ding on 2017/8/11.
//  Copyright © 2017年 Ding. All rights reserved.
//

import Foundation

public class NoteDAO{
    //私有的DateFormatter属性
    
    private var plistFilePath:String?
    private var array:NSMutableArray?
    public static let sharedInstance: NoteDAO = {
        let instance = NoteDAO()
        instance.initSandBox()
        //初始化沙箱目录中属性列表文件路径
        instance.array = NSMutableArray(contentsOfFile: instance.plistFilePath!)
        //初始化属性列表文件
        
        
        return instance
    }()
    func initSandBox(){
        self.plistFilePath = self.applicationDocumentsDirectoryFile()
        let fileManager = FileManager.default
        let exits = fileManager.fileExists(atPath: self.plistFilePath!)
        if (!exits){
            let bundle = Bundle(for: NoteDAO.self)
            let bundlePath = bundle.resourcePath as NSString?
            let defaultPath = bundlePath!.strings(byAppendingPaths: ["NotesList.plist"])
            do{
                try fileManager.copyItem(atPath: defaultPath[0], toPath: self.plistFilePath!)
            }catch{
                assert(false,"写入错误")
                
            }
        }
    }
    
    func applicationDocumentsDirectoryFile() -> String {
        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let path = (documentDirectory[0] as AnyObject).appendingPathComponent("NotesList.plist") as String
        return path
    }
    
    public func insert(date:String, content:String){
        let dict = NSDictionary(objects: [date,content], forKeys: ["date" as NSCopying,"content" as NSCopying])
        
        array!.add(dict)
        array!.write(toFile: self.plistFilePath!, atomically: true)
        
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
        return array!
    }
}
