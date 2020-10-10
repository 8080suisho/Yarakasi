//
//  TermsOfServiceViewController.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/11.
//

import UIKit

class TermsOfServiceViewController: UIViewController {
    
    @IBOutlet var okButton:UIButton!
    var ope:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let userDefaults = UserDefaults.standard
        let firstLunchKey = "firstLunchKey"
        if userDefaults.bool(forKey: firstLunchKey) {
            ope = 1
        }
    }
    
    @IBAction func start(){
        performSegue(withIdentifier: "toLogin", sender: self)
    }
    
}
