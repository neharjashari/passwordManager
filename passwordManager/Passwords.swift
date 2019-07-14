//
//  Passwords.swift
//  passwordManager
//
//  Created by Nehar Jashari on 7/13/19.
//  Copyright © 2019 Nehar Jashari. All rights reserved.
//

import Foundation

class Passwords {
    let id: Int64?
    var domain: String
    var password: String
    
    init(id: Int64) {
        self.id = id
        domain = ""
        password = ""
    }
    
    init(id: Int64, domain: String, password: String) {
        self.id = id
        self.domain = domain
        self.password = password
    }
}
