//
//  Angemeldet.swift
//  TestApp
//
//  Created by admin on 14.07.17.
//  Copyright © 2017 s65229. All rights reserved.
//

import Foundation


class Angemeldet: CustomStringConvertible {
    let idAng: Int64?
    var shopName: String
    var userName: String
    var shoeName: String
    var angemeldet: Bool
    
    init(idAng: Int64, shopName: String, userName: String, shoeName: String) {
        self.idAng = idAng
        self.shopName = shopName
        self.userName = userName
        self.shoeName = shoeName
        self.angemeldet = false
    }
    
    
    init(idAng: Int64, shopName: String, userName: String, shoeName: String, angemeldet: Bool) {
        self.idAng = idAng
        self.shopName = shopName
        self.userName = userName
        self.shoeName = shoeName
        self.angemeldet = angemeldet
    }
    var description: String {
        return "id = \(self.idAng ?? 0), shopName= \(self.shopName), userName = \(self.userName), shoeName = \(self.shoeName), angemeldet = \(self.angemeldet)."
    }
    
    
}
