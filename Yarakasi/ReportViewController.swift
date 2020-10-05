//
//  ReportViewController.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/05.
//

import UIKit
import Firebase

class ReportViewController: UIViewController {
    
    @IBOutlet var reportTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //自動でキーボードが出るようにする
        reportTextView.becomeFirstResponder()

    }
    
    //報告するのをキャンセル
    @IBAction func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
