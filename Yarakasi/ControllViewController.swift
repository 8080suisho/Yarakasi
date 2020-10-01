//
//  ControllViewController.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/02.
//

import UIKit
import PanModal

class ControllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView = UITableView()
    var array: [String] = ["投稿を非表示にする","投稿を削除する"]

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
    

    

}

extension ControllViewController: PanModalPresentable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(100)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
}
