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
    
    var report = ""
    var postTag = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //自動でキーボードが出るようにする
        reportTextView.becomeFirstResponder()

    }
    
    //報告を送る
    @IBAction func sendReport(){
        report = reportTextView.text!
        postTag = UserDefaults.standard.object(forKey: "postTag") as! String
        
        let db = Firestore.firestore().collection("report").document()
        
        db.setData([
                "report": report,
                "postID":postTag
            ]) { error in
            if error != nil {
                    // エラー処理
                    print("エラー")
                    return
                }
                // 成功したときの処理
                self.dismiss(animated: true, completion: nil)
            }
    }
    
    //報告するのをキャンセル
    @IBAction func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    

}
