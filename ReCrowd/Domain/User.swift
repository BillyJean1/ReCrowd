//
//  User.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 13-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import Foundation
import FirebaseAuth

class User: NSObject, NSCoding {
    public var name: String?
    public var email: String?
    public var id: String?
    
    init(id: String?, name: String?, email: String?) {
        super.init()
        self.name = name
        self.email = email
        self.id = id
        
        if name == nil && email != nil {
            self.name = self.stripNameFromEmail(email: email!)
        }
    }

    override init() {
        super.init()
        self.email = Auth.auth().currentUser?.email
        self.id = Auth.auth().currentUser?.uid
        self.name = Auth.auth().currentUser?.displayName

        if name == nil && email != nil {
            self.name = self.stripNameFromEmail(email: email!)
        }
    }
    
    private func stripNameFromEmail(email: String) -> String? {
        let delimiter = "@"
        name = email.components(separatedBy: delimiter)[0]
        return name
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? String ?? nil
        let name = aDecoder.decodeObject(forKey: "name") as? String ?? nil
        let email = aDecoder.decodeObject(forKey: "email") as?  String ?? nil
        self.init(id: id, name: name, email: email)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
    }
}
