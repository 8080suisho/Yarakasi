//
//  TermsOfServiceViewController.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/11.
//

import UIKit

class TermsOfServiceViewController: UIViewController {
    
    @IBOutlet var okButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "first") {
            
        }else{
            performSegue(withIdentifier: "toLogin", sender: self)
        }
    }
    
    @IBAction func start(){
        let userDefaults = UserDefaults.standard
        let firstLunch = ["first":false]
        userDefaults.set(firstLunch, forKey: "first")
        performSegue(withIdentifier: "toLogin", sender: self)
    }
    
}
