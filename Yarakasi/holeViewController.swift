//
//  holeViewController.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/14.
//

import UIKit
import Firebase

class holeViewController: UIViewController {
    
    @IBOutlet var holeLabel: UILabel!
    @IBOutlet var lebelLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var commentView: UIView!
    
    let db = Firestore.firestore()
    let ud = UserDefaults.standard
    
    var uid = ""
    var holeM = 0
    var me: AppUser!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentView.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        uid = UserDefaults.standard.object(forKey: "uid") as! String
        
        let userRef = self.db.collection("users").document("\(self.uid)")
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let user = AppUser(data: dataDescription!)
                //ユーザーの穴レベルを取得
                print(user.holeLebel)
                self.holeM = user.holeLebel
                
            } else {
                print("Document does not exist")
            }
            let hole = self.holeM * 5
            self.holeLabel.text = "\(hole)メートル"
            if hole >= 970 {
                self.lebelLabel.text = " ビンガム・キャニオン鉱山(アメリカ)級"
                self.commentLabel.text = "すごい！深すぎる！！"
            }else if hole >= 540 {
                self.lebelLabel.text = "バークリーピット(アメリカ)級"
                self.commentLabel.text = "この深さの人はそうそういない！"
            }else if hole >= 530 {
                self.lebelLabel.text = "レッドレイク(クロアチア)級"
                self.commentLabel.text = "すごい深さ！"
            }else if hole >= 525 {
                self.lebelLabel.text = "ミール鉱山(シベリア)級"
                self.commentLabel.text = "すごい深さ！"
            }else if hole >= 400 {
                self.lebelLabel.text = "フラニツェ・アビス(チェコ)級"
                self.commentLabel.text = "かなり深くなってきた！"
            }else if hole >= 300 {
                self.lebelLabel.text = "ドラゴンホール(中国)級"
                self.commentLabel.text = "なかなかの深さ！"
            }else if hole >= 250 {
                self.lebelLabel.text = "ダイアヴィク鉱山(カナダ)級"
                self.commentLabel.text = "なかなかの深さ！"
            }else if hole >= 200 {
                self.lebelLabel.text = "ディーンズ・ブルーホール(バハマ)級"
                self.commentLabel.text = "深くなってきた！"
            }else if hole >= 125 {
                self.lebelLabel.text = "グレート・ブルーホール(アメリカ)級"
                self.commentLabel.text = "深くなってきた！"
            }else if hole >= 90 {
                self.lebelLabel.text = "グローリーホールホール(カリフォルニア州)級"
                self.commentLabel.text = "まだまだ深くなる！？"
            }else if hole >= 30 {
                self.lebelLabel.text = "地獄の門(トルクメニスタン)級"
                self.commentLabel.text = "深いっちゃあ深い"
            }else {
                self.lebelLabel.text = "普通の穴"
                self.commentLabel.text = "世の中にはもっと深い穴がある！"
            }
        }
        
    }
    
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
