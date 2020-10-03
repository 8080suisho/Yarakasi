//
//  ContainerViewController.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/03.
//

import UIKit
import MaterialComponents
 
class ContainerViewController: UIViewController {
    
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius = 32
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    @IBAction func tapBottomButtonAction(_ sender: Any) {
        print("Bottomボタンが押されました")
    }
    
    
    //ログアウトしログイン画面へ
    @IBAction func logout(){
        UserDefaults.standard.removeObject(forKey: "loginChatName")
        self.dismiss(animated: true, completion: nil)
    }
    
}
