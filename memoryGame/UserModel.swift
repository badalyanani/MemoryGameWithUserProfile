//
//  UserModel.swift
//  memoryGame
//
//  Created by Ani on 11/8/19.
//  Copyright © 2019 Ani. All rights reserved.
//

import Foundation

class UserModel: NSObject {
    
    static var shared = UserModel(userName: "An", password: "pass", score: 0)
    
    var userName: String?
    var password: String?
    @objc dynamic var score: Int = 0
    
    init(userName: String, password: String, score: Int ) {
        self.userName = userName
        self.password = password
        self.score = score
    }
    
}
