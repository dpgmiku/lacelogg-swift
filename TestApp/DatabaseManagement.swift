//
//  DatabaseManagement.swift
//  TestApp
//
//  Created by admin on 01.07.17.
//  Copyright © 2017 s65229. All rights reserved.
//

import Foundation
import SQLite

class DatabaseManagement {
    static let shared: DatabaseManagement = DatabaseManagement()
    private let db: Connection?
    
    private let tblProduct = Table("users")
    private let id = Expression<Int64>("id")
    private let name = Expression<String?>("name")
    private let vorname = Expression<String>("vorname")
    private let email = Expression<String>("email")
    private let password = Expression<String>("password")
    
    private let tblAsortiment = Table("asortiments")
    private let idShoe = Expression<Int64>("idShoe")
    private let shop = Expression<String>("shop")
    private let nameShoe = Expression<String>("nameShoe")
    private let image = Expression<String>("image")
    private let anzahl = Expression<Int>("anzahl")
    
    private let tblAngemeldet = Table("angemeldet")
    private let idAng = Expression<Int64>("idAng")
    private let shopName = Expression<String>("shopName")
    private let userName = Expression<String>("userName")
    private let shoeName = Expression<String>("shoeName")
    private let angemeldet = Expression<Bool>("angemeldet")
    

    
    private init() {
      let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        do {
            db = try Connection("\(path)/ishop.sqlite3")
            createTableProduct()
        }
        catch {
            db = nil
            print("Unable to open database")
            
            
        }   
    }
    
    
    func createTableAsortiment() {
        do {
            try db!.run(tblAsortiment.create(ifNotExists: true) { table in table.column(idShoe, primaryKey: true)
                table.column(shop)
                table.column(nameShoe)
                table.column(email, unique: true)
                table.column(password)
            })
            print("create table successfully")
        } catch {
            
            print("Unable to create table")
        }
    }
    func createTableProduct() {
        do {
            try db!.run(tblProduct.create(ifNotExists: true) { table in table.column(id, primaryKey: true)
                table.column(name)
                table.column(vorname)
                table.column(email, unique: true)
                table.column(password)
            })
            print("create table successfully")
        } catch {
            
            print("Unable to create table")
        }
        
            
        }
    
       
    
    func createTableangemeldet() {
        do {
            try db!.run(tblAngemeldet.create(ifNotExists: true) { table in table.column(idAng, primaryKey: true)
                table.column(shopName)
                table.column(userName)
                table.column(shoeName)
                table.column(angemeldet)
            })
            print("create table successfully")
        } catch {
            
            print("Unable to create table")
        }
        
        
    }

    
    
    func addProduct(inputName: String, inputVorname: String, inputEmail: String, inputPassword: String) -> Int64? {
        do {
        let insert = tblProduct.insert(name <- inputName, vorname <- inputVorname, email <- inputEmail, password <- inputPassword)
            let id = try db!.run(insert)
            print("Inserted to the tblProduct successfully")
            return id
        } catch {
            
            print("Cannot insert to database")
            return nil
        }
        }
    
    func addAsortiment(inputShop: String, inputNameShoe: String, inputImage: String, inputAnzahl: Int) -> Int64? {
        do {
            let insert = tblAsortiment.insert(shop <- inputShop, nameShoe <- inputNameShoe, image <- inputImage, anzahl <- inputAnzahl)
            let id = try db!.run(insert)
            print("Inserted to the tblAsortiment successfully")
            return id
        } catch {
            
            print("Cannot insert to database")
            return nil
        }
    }
    
    
    func addAngemeldet(inputShop: String, inputUsername: String, inputShoe: String, inputAngemeldet: Bool) -> Int64? {
        do {
            let insert = tblAngemeldet.insert(shopName <- inputShop, userName <- inputUsername, shoeName <- inputShoe, angemeldet <- inputAngemeldet)
            let id = try db!.run(insert)
            print("Inserted to the tblAngemeldet successfully")
            return id
        } catch {
            
            print("Cannot insert to database")
            return nil
        }
    }
    
    
    func queryAllProduct() -> [Product] {
        var products = [Product]()
        
        do {
            for product in try db!.prepare(self.tblProduct) {
                let newProduct = Product(id: product[id],
                                         name: product[name] ?? "",
                                         vorname: product[vorname],
                                         email: product[email],
                                         password: product[password]
                                         )
                products.append(newProduct)
            }
        } catch {
            print("Cannot get list of product")
        }
        for product in products {
            print("each product = \(product)")
        }
        return products
    }
    
    func queryAllAsortiments() -> [Asortiment] {
        var asortiments = [Asortiment]()
        
        do {
            for asortiment in try db!.prepare(self.tblAsortiment) {
                let newAsortiment = Asortiment(idShoe: asortiment[idShoe],
                                         shop: asortiment[shop],
                                         nameShoe: asortiment[nameShoe],
                                         image: asortiment[image],
                                         anzahl: asortiment[anzahl]
                )
                asortiments.append(newAsortiment)
            }
        } catch {
            print("Cannot get list of asortiments")
        }
        for asortiment in asortiments {
            print("each asortiment = \(asortiment)")
        }
        return asortiments
    }
    
    func findAsortimentOfShop(inputShop: String) -> [Asortiment] {
        var asortiments = [Asortiment]()
        
        do {
            for asortiment in try db!.prepare(self.tblAsortiment.filter(shop == inputShop)) {
                let newAsortiment = Asortiment(idShoe: asortiment[idShoe],
                                               shop: asortiment[shop],
                                               nameShoe: asortiment[nameShoe],
                                               image: asortiment[image],
                                               anzahl: asortiment[anzahl]
                )
                asortiments.append(newAsortiment)
            }
        } catch {
            print("Cannot get list of asortiments")
        }
        for asortiment in asortiments {
            print("each asortiment = \(asortiment)")
        }
        return asortiments
    }
    
    
    func findAngemeldet(inputUsername: String, inputShop: String, inputShoe: String) -> Bool {
        do {
            for ang in try db!.prepare(self.tblAngemeldet.filter(shopName == inputShop && userName == inputUsername && shoeName == inputShoe)) {
              return ang[angemeldet]
            }
        } catch {
            return false
        }
        
        
        return false
    }

  
    
    
    
    
    func findProduct(inputEmail: String) -> String {
        var returnpassword = ""
        
        do {
            for product in try db!.prepare(self.tblProduct.filter(email == inputEmail)) {
                returnpassword = product[password]
                
            }
        } catch {
        return ""
        }
        
        
        return returnpassword
    }

    
    
    func findAnzahl(shoeNameGive: String, shopNamevar: String) -> Int {
        let anzahlback = -1
        
        do {
            for asort in try db!.prepare(self.tblAsortiment.filter(nameShoe == shoeNameGive && shop == shopNamevar)) {
return asort[anzahl]
            }
        } catch {
            return anzahlback
        }
        
        
        return anzahlback
    }

    
    func updateAnzahl(shoeNameGive: String, PlusOderMinus: String) -> Bool {
        let tblFilterAsortiment = tblAsortiment.filter(nameShoe == shoeNameGive)
        do {
            if (PlusOderMinus == "-")
            {
            
            let update = tblFilterAsortiment.update([
                shop <- shop,
                nameShoe <- nameShoe,
                image <- image,
                anzahl <- anzahl - 1
                ])
                if try db!.run(update) > 0 {
                    print("Update contact successfully")
                    return true
                }
                }
            else {
                
              let update = tblFilterAsortiment.update([
                shop <- shop,
                nameShoe <- nameShoe,
                image <- image,
                anzahl <- anzahl + 1
                ])
                if try db!.run(update) > 0 {
                    print("Update contact successfully")
                    return true
                }
            }
            
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }

    
    
        
    
    
    
    
    func updateContact(productId:Int64, newProduct: Product) -> Bool {
        let tblFilterProduct = tblProduct.filter(id == productId)
        do {
            let update = tblFilterProduct.update([
                name <- newProduct.name,
                vorname <- newProduct.vorname,
                email <- newProduct.email,
                password <- newProduct.password
                ])
            if try db!.run(update) > 0 {
                print("Update contact successfully")
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }
    
    func updateAngemeldet(shop: String, user: String, shoe: String) -> Bool {
        let tblAngemeldets = tblAngemeldet.filter(shopName == shop && userName == user && shoeName == shoe)

        do {
            let update = tblAngemeldets.update([
                shopName <- shopName,
                userName <- userName,
                shoeName <- shoeName,
                angemeldet <- !(angemeldet)
                ])
            if try db!.run(update) > 0 {
                print("Update contact successfully")
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }

    func deleteProduct(inputId: Int64) -> Bool {
        do {
            let tblFilterProduct = tblProduct.filter(id == inputId)
            try db!.run(tblFilterProduct.delete())
            print("delete sucessfully")
            return true
        } catch {
            
            print("Delete failed")
        }
        return false
    }
    
    
    func deleteAsortiment(nameOfShoe: String) -> Bool {
        do {
            let tblFilterAsortiment = tblAsortiment.filter(nameOfShoe == nameShoe)
            try db!.run(tblFilterAsortiment.delete())
            print("delete sucessfully")
            return true
        } catch {
            
            print("Delete failed")
        }
        return false
    }
    
    
    
    
    
}


