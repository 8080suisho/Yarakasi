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
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        //名前入力欄のカスタム
        loginNameTextField.attributedPlaceholder = NSAttributedString(string: "ログインネーム", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        loginNameTextField.addBorderBottom(height: 1.0, color: UIColor(hex: "5a4498", alpha: 1.0))
        
        //メールアドレス入力欄のカスタム
        emailTextField.attributedPlaceholder = NSAttributedString(string: "メールアドレス", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        emailTextField.addBorderBottom(height: 1.0, color: UIColor(hex: "5a4498", alpha: 1.0))
        
        //パスワード入力欄のカスタム
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "パスワード(6文字以上英数字)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        passwordTextField.addBorderBottom(height: 1.0, color: UIColor(hex: "5a4498", alpha: 1.0))
        
        //ボタンのカスタム
        loginButton.layer.cornerRadius = 20
    }
    
    //ログイン
    @IBAction func login(){
        
        let ud = UserDefaults.standard
        
        //ユーザー名をUDに保存
        ud.set(loginNameTextField.text, forKey: "loginChatName")
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil, let result = result {
                result.user.sendEmailVerification(completion: { (error) in
                    if error == nil {
                        let alert = UIAlertController(title: "仮登録を行いました。", message: "入力したメールアドレス宛に確認メールを送信しました。", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    
    
    
  //ログアウトしたときに名前入力欄に前の名前が残らないようにする
    override func viewWillAppear(_ animated: Bool) {
        loginNameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            Auth.auth().currentUser?.reload(completion: { error in
                if error == nil {
                    if Auth.auth().currentUser?.isEmailVerified == true {
                        self.performSegue(withIdentifier: "toChat", sender: Auth.auth().currentUser!)
                    } else if Auth.auth().currentUser?.isEmailVerified == false {
                        let alert = UIAlertController(title: "確認用メールを送信しているので確認をお願いします。", message: "まだメール認証が完了していません。", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
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

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
