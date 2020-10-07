//
//  ChatViewController.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/02.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var listTableView: UITableView!
    var me: AppUser!
    var uid = ""
    var userName = ""
    var hidePost = ""
    var hidePostArray = [String]()
    
    
    var postArray = [Post]()
    var userArray = [AppUser]()
    
    let db = Firestore.firestore()
    let ud = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        let xib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        listTableView.register(xib, forCellReuseIdentifier: "Cell")
        
        
    }
    
    //firestoreからデータを読み込む
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        db.collection("posts").order(by: "createdAt", descending: true).getDocuments { (snapshot, error) in
            if error == nil, let snapshot = snapshot {
                self.postArray = []
                for document in snapshot.documents {
                    let data = document.data()
                    let post = Post(data: data)
                    self.postArray.append(post)
                }
                self.listTableView.reloadData()
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChatTableViewCell
        
        cell.messageLabel?.text = postArray[indexPath.row].content
        cell.dateLabel?.text = postArray[indexPath.row].postTime
        cell.nameLabel?.text = postArray[indexPath.row].userName
        
        
        
        cell.button.addTarget(self, action: #selector(self.buttonEvent(_: )), for: UIControl.Event.touchUpInside)
        cell.button.tag = indexPath.row
        
        return cell
    }
    
    //Cellのボタンを押したらメニューを表示
    @objc func buttonEvent(_ sender: UIButton) {
        print("tapped: \([sender.tag])番目のcell")
        let senderTag = postArray[sender.tag].postID
        
        //報告したい投稿の保存
        ud.set(senderTag, forKey: "reportPost")
        
        //非表示にしたい投稿の保存
        ud.set(senderTag, forKey: "hidePost")
        
        //非表示にしたい投稿をusersコレクションに追加
        uid = UserDefaults.standard.object(forKey: "uid") as! String
        hidePost = UserDefaults.standard.object(forKey: "hidePost") as! String
        hidePostArray.append(hidePost)
        let hideRef = db.collection("users").document("\(uid)")
        hideRef.updateData([
            "hidePostArray": hidePostArray
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        //メニューを表示
        presentPanModal(ControllViewController())
    }
    
    
}
