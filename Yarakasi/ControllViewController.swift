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
    var array: [String] = ["投稿を非表示にする","この投稿を報告する"]

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
        if indexPath.row == 1 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextView = storyboard.instantiateViewController(withIdentifier: "Report") as! ReportViewController
            self.present(nextView, animated: true, completion: nil)
            print("報告")
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
        return .contentHeight(100)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    
}
