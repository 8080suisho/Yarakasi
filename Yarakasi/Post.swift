//
//  Post.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/02.
//

import Foundation
import Firebase

struct Post {
    let userName: String
    let content: String
    let postID: String
    let senderID: String
    let love: [String]
    let jibun: [String]
    let postTime: String
    let createdAt: Timestamp
    let updatedAt: Timestamp
    
    
    init(data: [String: Any]) {
        userName = data["userName"] as! String
        content = data["content"] as! String
        postID = data["postID"] as! String
        senderID = data["senderID"] as! String
        postTime = data["postTime"] as! String
        love = data["love"] as! [String]
        jibun = data["jibun"] as! [String]
        createdAt = data["createdAt"] as! Timestamp
        updatedAt = data["updatedAt"] as! Timestamp
        
    }
}
