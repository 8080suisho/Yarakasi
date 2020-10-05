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
        loginNameTextField.attributedPlaceholder = NSAttributedString(string: "ログインネーム", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        loginNameTextField.addBorderBottom(height: 1.0, color: UIColor(hex: "5a4498", alpha: 1.0))
        
        //ボタンのカスタム
        loginButton.layer.cornerRadius = 20
    }
    
    
    
    
  //ログアウトしたときに名前入力欄に前の名前が残らないようにする
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
    
    //ログイン
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


//色を16進数で指定
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}
