//
//  SigninViewController.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/06.
//

import UIKit
import Firebase

class SigninViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var loginNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signinButton: UIButton!

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
        signinButton.layer.cornerRadius = 20
    }
    
    //ログアウトしたときに名前入力欄に前の名前が残らないようにする
      override func viewWillAppear(_ animated: Bool) {
          loginNameTextField.text = ""
          emailTextField.text = ""
          passwordTextField.text = ""
      }
    
    @IBAction func siginin(){
        
        let ud = UserDefaults.standard
        
        //ユーザー名をUDに保存
        ud.set(loginNameTextField.text, forKey: "loginChatName")
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error == nil, let result = result, result.user.isEmailVerified {
                self.performSegue(withIdentifier: "Chat", sender: result.user)
            }
        }
    }
    

    

}
