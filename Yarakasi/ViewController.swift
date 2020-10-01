//
//  ViewController.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/01.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet var loginNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginNameTextField.placeholder = "ログインネーム"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginNameTextField.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //もしユーザー名が保存されてるなら
        if let _ = UserDefaults.standard.object(forKey: "loginChatName") {
             performSegue(withIdentifier: "toChat", sender: nil)
        }
    }
    
    @IBAction func login(){
        //もしtextFieldに文字が入力されてるなら
          if loginNameTextField.text != "" {
                
              let ud = UserDefaults.standard
                
              //ユーザー名をUDに保存
              ud.set(loginNameTextField.text, forKey: "loginChatName")
                
              //次の画面に遷移するなど
              performSegue(withIdentifier: "toChat", sender: nil)
                
          //もしtextFieldに何も入力されてなければ
          } else {
            print("名前を入力してください")


          }

    }

}

