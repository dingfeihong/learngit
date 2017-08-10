//
//  SandBox.swift
//  MyNote
//
//  Created by Ding on 2017/8/10.
//  Copyright © 2017年 Ding. All rights reserved.
//

import Foundation
public class SandBox{
    
    
    
    
    //私有的DateFormatter属性
    private var dateFormatter = DateFormatter()
    //私有的沙箱目录中属性列表文件路径
    private var plistFilePath: String!
    
    public static let sharedInstance: SandBox = {
        let instance = SandBox()
        
        //初始化沙箱目录中属性列表文件路径
        instance.plistFilePath = instance.applicationDocumentsDirectoryFile()
        //初始化DateFormatter
        instance.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //初始化属性列表文件
        instance.initSandBox()
        
        return instance
    }()
    
    
    
    
    
    
    func initSandBox(){
        let fileManager = FileManager.default
        let exits = fileManager.fileExists(atPath: self.plistFilePath!)
        if (!exits){
            let bundle = Bundle(for: SandBox.self)
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
    
    public func create(model:Note){
        let array = NSMutableArray(contentsOfFile: self.plistFilePath!)
        let strDate = self.dateFormatter.string(from: model.date)
        let dict = NSDictionary(objects: [strDate,model.content], forKeys: ["date" as NSCopying,"content" as NSCopying])
        
        array?.add(dict)
        array?.write(toFile: self.plistFilePath!, atomically: true)
        
    }
    public func findAll() -> [String]?{
        let array = NSMutableArray(contentsOfFile: self.plistFilePath!)
        var listData = [String]()
        for item in array!{
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            listData.append(strDate)
            let content = dict["content"] as! String
            
            listData.append(content)
            
        }
        return listData
    }
}
