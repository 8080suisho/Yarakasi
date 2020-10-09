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
    var newFilterArray = [Post]()
    
    let db = Firestore.firestore()
    let ud = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        let xib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        listTableView.register(xib, forCellReuseIdentifier: "Cell")
        
        self.listTableView.estimatedRowHeight = 120
        self.listTableView.rowHeight = UITableView.automaticDimension
        
        
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
                    //全ポストを取得した配列
                    self.postArray.append(post)
                }
                
                //usersコレクションを配列に入れる
                self.uid = UserDefaults.standard.object(forKey: "uid") as! String
                
                let userRef = self.db.collection("users").document("\(self.uid)")
                
                userRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data()
                        let user = AppUser(data: dataDescription!)
                        //非表示にしたいポストが入った配列
                        self.filterArray = (user.hidePostArray)
                        //全ポストから非表示にしたいポストを除いた配列
                        self.newFilterArray = self.postArray.filter({ !self.filterArray.contains($0.postID) })
                        print("完了")
                        self.postArray = self.newFilterArray
                        print(self.postArray)
                        self.listTableView.reloadData()
                        
                        
                    } else {
                        print("Document does not exist")
                    }
                }
                
    
                
            }
        }
        
        
        
        

        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postArray.count
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
