//
//  User.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 13-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import Foundation
import FirebaseAuth

class User {
    public var name: String?
    public var email: String?
    public var id: String?
    
    init(id: String?, name: String?, email: String?) {
        self.name = name
        self.email = email
        self.id = id
    }

    init() {
        self.email = Auth.auth().currentUser?.email
        self.id = Auth.auth().currentUser?.uid
        self.name = Auth.auth().currentUser?.displayName

        if name == nil && email != nil {
            let delimiter = "@"
            name = email?.components(separatedBy: delimiter)[0] ?? nil
        }
    }
}
