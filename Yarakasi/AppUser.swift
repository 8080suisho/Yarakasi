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

    init(data: [String: Any]) {
        userID = data["userID"] as! String
        userName = data["userName"] as! String
    }
}
