//
//  passwordDB.swift
//  passwordManager
//
//  Created by Nehar Jashari on 7/14/19.
//  Copyright © 2019 Nehar Jashari. All rights reserved.
//

import Foundation
import SQLite

class passwordDB {
    static let instance = passwordDB()
    private let db: Connection?
    
    private let passwords = Table("passwords")
    private let id = Expression<Int64>("id")
    private let domain = Expression<String?>("domain")
    private let password = Expression<String>("password")
    
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/passwordsDB.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        createTable()
    }
    
    
    func createTable() {
        do {
            try db!.run(passwords.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(domain)
                table.column(password)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    
    func addPassword(cdomain: String, cpassword: String) -> Int64? {
        do {
            let insert = passwords.insert(domain <- cdomain, password <- cpassword)
            let id = try db!.run(insert)
            
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    
    func getPassword() -> [Passwords] {
        var passwords = [Passwords]()
        
        do {
            for passwordRow in try db!.prepare(self.passwords) {
                passwords.append(Passwords(
                    id: passwordRow[id],
                    domain: passwordRow[domain]!,
                    password: passwordRow[password]))
            }
        } catch {
            print("Select failed")
        }
        
        return passwords
    }
    
    
    func deletePassword(cid: Int64) -> Bool {
        do {
            let password = passwords.filter(id == cid)
            try db!.run(password.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
    
    func updatePassword(cid:Int64, newPassword: Passwords) -> Bool {
        let passwordSelected = passwords.filter(id == cid)
        do {
            let update = passwordSelected.update([
                domain <- newPassword.domain,
                password <- newPassword.password
                ])
            if try db!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }
    
    
}
