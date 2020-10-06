//
//  ContainerViewController.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/03.
//

import UIKit
import MaterialComponents
import Firebase
 
class ContainerViewController: UIViewController {
    
    @IBOutlet var button: UIButton!
    
    var me:AppUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius = 32
        
        //NavigationBarの色
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "5a4498", alpha: 1.0)
        
        //Navigationbarのボタンの色
        self.navigationController?.navigationBar.tintColor = .white
    }
 
    @IBAction func tapBottomButtonAction(_ sender: Any) {
        print("Bottomボタンが押されました")
    }
    
    
    //ログアウトしログイン画面へ
    @IBAction func logout(){
        try? Auth.auth().signOut()
        UserDefaults.standard.removeObject(forKey: "loginChatName")
        self.dismiss(animated: true, completion: nil)
    }
    
}
