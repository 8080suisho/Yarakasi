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
    var userName = ""
    var userID = ""
    
    var postArray = [Post]()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        let xib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        listTableView.register(xib, forCellReuseIdentifier: "Cell")
        
        
        //usersコレクションを追加
        userName = UserDefaults.standard.object(forKey: "loginChatName") as! String
        userID = UserDefaults.standard.object(forKey: "uid") as! String
        
        db.collection("users").document().setData([
            "userName": userName,
            "userID": userID
        ]){ error in
            if error == nil {
                
            }
        }
        
        
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
        presentPanModal(ControllViewController())
    }
    

}
