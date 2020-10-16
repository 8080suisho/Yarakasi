//
//  ChatTableViewCell.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/02.
//

import UIKit
import Firebase

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var button: UIButton!
    
    @IBOutlet var loveButton: UIButton!
    @IBOutlet var loveLabel: UILabel!
    
    @IBOutlet var jibunButton: UIButton!
    @IBOutlet var jibunLabel: UILabel!
    
    
    
    
    let db = Firestore.firestore()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }
    
    @IBAction func tapButton(){
        
    }
    
    
    @IBAction func tapLoveButton(){
        
    }
    
    @IBAction func tapJibunButton(){
        
    }
    
    
    
    
}

