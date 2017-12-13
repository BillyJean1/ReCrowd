//
//  User.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 13-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import Foundation

class User {
    public var name: String?
    public var email: String?
    public var id: String?
    
    init(id: String?, name: String?, email: String?) {
        self.name = name
        self.email = email
        self.id = id
    }
}
