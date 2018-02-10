//
//  Asortiment.swift
//  TestApp
//
//  Created by admin on 13.07.17.
//  Copyright © 2017 s65229. All rights reserved.
//

import Foundation

class Asortiment: CustomStringConvertible {
    let idShoe: Int64?
    var shop:  String
    var nameShoe: String
    var image: String
    var anzahl: Int
    
    init(idShoe: Int64, shop: String, nameShoe: String, image: String, anzahl: Int) {
        self.idShoe = idShoe
        self.shop = shop
        self.nameShoe = nameShoe
        self.image = image
        self.anzahl = anzahl
    }
    var description: String {
        return "id = \(self.idShoe ?? 0), shop = \(self.shop), name = \(self.nameShoe), image = \(self.image), anzahl = \(self.anzahl)."
    }
    
    
}
