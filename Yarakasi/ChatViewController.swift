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
    var filterArray = [String]()
    
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
    
    //チャット画面が表示されるたびfirestoreからデータを読み込む
    override func viewWillAppear(_ animated: Bool) {
        
        //postコレクションを配列に入れる
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
        
        //usersコレクションを配列に入れる
        uid = UserDefaults.standard.object(forKey: "uid") as! String
        
        let userRef = db.collection("users").document("\(uid)")
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let user = AppUser(data: dataDescription!)
                self.filterArray = (user.hidePostArray)
                print(self.filterArray)
                print("これはフィルター")
                //非表示の投稿のドキュメントを取得
                
            } else {
                print("Document does not exist")
                
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
        
        //メニューを表示
        presentPanModal(ControllViewController())
    }
    
    
}
