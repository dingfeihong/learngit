//
//  SignInController.swift
//  MyAlamofire
//
//  Created by Ding on 2017/9/2.
//  Copyright © 2017年 Ding. All rights reserved.
//

import UIKit
import Alamofire
class SignInController: UIViewController {

 
    @IBOutlet weak var signRes: UILabel!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var userStatus: UILabel!
    @IBOutlet weak var userName: UILabel!
    var m_model: UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = m_model?.GetName()
       
        if m_model?.GetStatus() == true{
            signButton.setTitle("签出", for: .normal)
            let time = m_model?.GetTime()
            userStatus.text = "已签入\(time!)"
            signButton.addTarget(self, action: #selector(SignOut), for: UIControlEvents.touchUpInside)
        }else{
            signButton.setTitle("签入", for: .normal)
            userStatus.text = "已签出"
            signButton.addTarget(self, action: #selector(SignIn), for: UIControlEvents.touchUpInside)
        }
        // Do any additional setup after loading the view.
    }
    func SignIn(){
        let id = m_model?.GetID()
        let url = "http://10.131.200.20/CISWORK/php/signForWin.php"
        let params =  ["userid": id!, "signflag":"1", "type": "JSON", "action": "query"]
        
        Alamofire.request(url, method: .post, parameters: params).responseJSON {
            response in
            guard let JSON = response.result.value else { return }
            let date = Date()
            self.m_model?.SetTime(time: date)
            
            self.signRes.text = "签入成功"
            self.userStatus.text = "已签入:\(self.m_model?.GetTime())"
            
            self.m_model?.SetStatus(status: true)
            print("JSON: \(JSON)")
            
            self.signButton.setTitle("签出", for: .normal)
            
            self.signButton.removeTarget(self, action: #selector(self.SignIn), for: UIControlEvents.touchUpInside)
            self.signButton.addTarget(self, action: #selector(self.SignOut), for: UIControlEvents.touchUpInside)

            
        }

    }
    
    func SignOut(){
        let url = "http://10.131.200.20/CISWORK/php/signForWin.php"
        let id = m_model?.GetID()
        let params =  ["userid": id!, "signflag":"0", "type": "JSON", "action": "query"]
        
        Alamofire.request(url, method: .post, parameters: params).responseJSON {
            response in
            let JSON = response.result.value
            //guard let JSON = response.result.value else { return }
            self.signRes.text = "签出成功"
            self.userStatus.text = "已签出"
            self.m_model?.SetStatus(status: false)
            print("JSON: \(JSON)")
            self.signButton.setTitle("签入", for: .normal)
            self.signButton.removeTarget(self, action: #selector(self.SignOut), for: UIControlEvents.touchUpInside)
            self.signButton.addTarget(self, action: #selector(self.SignIn), for: UIControlEvents.touchUpInside)
            
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
