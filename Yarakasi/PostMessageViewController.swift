//
//  PostMessageViewController.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/02.
//

import UIKit
import Firebase

class PostMessageViewController: UIViewController {
    
    @IBOutlet  var wordCountLabel: UILabel!
    @IBOutlet  var textView: UITextView!
    var me: AppUser!
    
    fileprivate var maxWordCount: Int = 100 //最大文字数
    fileprivate let placeholder: String = "テキストを入力・・・" //プレイスホルダー
    
    
    @IBOutlet var postButton: UIButton!
    
    var content = ""
    var userName = ""
    var senderID = ""
    var postTime = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postButton.layer.cornerRadius = 15
        
        //自動でキーボードが出るようにする
        textView.becomeFirstResponder()
        
        self.textView.delegate = self
        //タップでキーボードを下げる
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        //下にスワイプでキーボードを下げる
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipeDownGesture.direction = .down
        self.view.addGestureRecognizer(swipeDownGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    
    //投稿ボタンを押したらfirestoreに保存
    @IBAction func post(){
        content = textView.text!
        userName = UserDefaults.standard.object(forKey: "loginChatName") as! String
        senderID = UserDefaults.standard.object(forKey: "uid") as! String
        
        let date = Date()
        let df = DateFormatter()
        
        df.dateFormat = "yyyy/MM/dd"
        postTime = (df.string(from: date))
        
        let db = Firestore.firestore().collection("posts").document()
        
        db.setData([
                "userName": userName,
                "content": content,
                "postID": db.documentID,
                "senderID": senderID,
                "postTime":postTime,
                "createdAt": FieldValue.serverTimestamp(),
                "updatedAt": FieldValue.serverTimestamp()
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
    
    //投稿するのをキャンセル
    @IBAction func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}


extension PostMessageViewController: UITextViewDelegate {
    
func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let existingLines = textView.text.components(separatedBy: .newlines)//既に存在する改行数
    let newLines = text.components(separatedBy: .newlines)//新規改行数
    let linesAfterChange = existingLines.count + newLines.count - 1 //最終改行数。-1は編集したら必ず1改行としてカウントされるから。
    return linesAfterChange <= 10 && textView.text.count + (text.count - range.length) <= maxWordCount
}
    
func textViewDidChange(_ textView: UITextView) {
    let existingLines = textView.text.components(separatedBy: .newlines)//既に存在する改行数
    if existingLines.count <= 3 {
        self.wordCountLabel.text = "\(maxWordCount - textView.text.count)/100"
    }
}
        
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = .darkText
        }
    }
 
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
           textView.textColor = .darkGray
           textView.text = placeholder
        }
    }
    
}
