//
//  ViewController.swift
//  MyAlamofire
//
//  Created by Ding on 2017/9/1.
//  Copyright © 2017年 Ding. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    private let webBL = WebBL.sharedInstance
    var model: UserModel = UserModel()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //NotificationCenter.default.addObserver(self, selector: "signIn", name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
    }

    @IBAction func LogIn(_ sender: Any) {
        let url = "http://10.131.200.20/CISWORK/php/getStatusForWin.php"
        let params =  ["username": userName.text!, "password":passWord.text!, "type": "JSON", "action": "query"]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON {
            response in
            guard let JSON = response.result.value else { return }
            
            
            let res = JSON as! NSDictionary
            let id = res.value(forKey: "userid") as! String
            let time = res.value(forKey: "signtime") as! String
            let sign = (res.value(forKey: "signflag") as! String) == "1" ? true:false
            
            self.model.load(name: self.userName.text!, pswd: self.passWord.text!, id: id, status: sign, time: time)
            print("JSON: \(JSON)")
            
         /*
            var thirdVC = self.storyboard?.instantiateViewController(withIdentifier: "login") as! SignInController
            thirdVC.model = self.model
            self.navigationController?.pushViewController(thirdVC, animated: true)
            */
            self.performSegue(withIdentifier:"login", sender: self)

        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login"{
            let controller = segue.destination as! SignInController
            controller.m_model = self.model
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

