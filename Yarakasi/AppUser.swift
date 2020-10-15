//
//  AppUser.swift
//  Yarakasi
//
//  Created by 諸星水晶 on 2020/10/05.
//

import Foundation
import Firebase


struct AppUser {
    let userID: String
    let userName: String
    let hidePostArray: [String]
    let blockUserArray: [String]
    let holeLebel: Int

    init(data: [String: Any]) {
        userID = data["userID"] as! String
        userName = data["userName"] as! String
        blockUserArray = data["blockUserArray"] as! [String]
        hidePostArray = data["hidePostArray"] as! [String]
        holeLebel = data["holeLebel"] as! Int
    }
}
