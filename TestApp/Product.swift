//
//  Product.swift
//  TestApp
//
//  Created by admin on 01.07.17.
//  Copyright © 2017 s65229. All rights reserved.
//

import Foundation

class Product: CustomStringConvertible {
    let id: Int64?
    var name: String
    var vorname: String
    var email: String
    var password: String
    
    init(id: Int64, name: String, vorname: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.vorname = vorname
        self.email = email
        self.password = password
    }
    var description: String {
        return "id = \(self.id ?? 0), name = \(self.name), vorname = \(self.vorname), email = \(self.email), passwd = \(self.password)."
    }
    
    
}
