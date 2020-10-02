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
    @IBOutlet var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //名前入力欄のカスタム
        loginNameTextField.attributedPlaceholder = NSAttributedString(string: "名前を入力してください。", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        loginNameTextField.addBorderBottom(height: 1.0, color: UIColor.purple)
        
        //ボタンのカスタム
        loginButton.layer.cornerRadius = 20
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

//名前入力欄のカスタム
extension UITextField {
    func addBorderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
        self.borderStyle = .none
    }
}

