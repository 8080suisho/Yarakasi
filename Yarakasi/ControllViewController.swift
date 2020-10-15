//
//  ControllViewController.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/02.
//

import UIKit
import PanModal
import Firebase

class ControllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView = UITableView()
    var array: [String] = ["投稿を非表示にする","この投稿を報告する","このユーザーをブロックする"]
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height)
        
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = array[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)    //選択解除
        if indexPath.row == 0 {
            //非表示にしたい投稿をusersコレクションに追加
            let hidePost = UserDefaults.standard.object(forKey: "postTag") as! String
            let uid = UserDefaults.standard.object(forKey: "uid") as! String
            let hideRef = db.collection("users").document("\(uid)")
            hideRef.updateData([
                "hidePostArray": FieldValue.arrayUnion([hidePost])
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            self.dismiss(animated: true, completion: nil)
        //報告の処理
        }else if indexPath.row == 1 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextView = storyboard.instantiateViewController(withIdentifier: "Report") as! ReportViewController
            self.present(nextView, animated: true, completion: nil)
            print("報告")
            
        //ブロックの処理
        }else if indexPath.row == 2 {
            let blockUser = UserDefaults.standard.object(forKey: "blockUser") as! String
            let uid = UserDefaults.standard.object(forKey: "uid") as! String
            if blockUser != uid {
                //自分のリストに相手を追加
                let BlockRef = db.collection("users").document("\(uid)")
                BlockRef.updateData([
                    "blockUserArray": FieldValue.arrayUnion([blockUser])
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
                //相手のリストに自分を追加
                let BlockUserRef = db.collection("users").document("\(blockUser)")
                BlockUserRef.updateData([
                    "blockUserArray": FieldValue.arrayUnion([uid])
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
                self.dismiss(animated: true, completion: nil)
                
            }else {
                let alert = UIAlertController(title: nil, message: "自分はブロックできません。", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
    

}

extension ControllViewController: PanModalPresentable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(150)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    
}
