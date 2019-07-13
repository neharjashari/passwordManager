//
//  DatabaseTestViewController.swift
//  passwordManager
//
//  Created by Nehar Jashari on 7/13/19.
//  Copyright © 2019 Nehar Jashari. All rights reserved.
//

import UIKit
import SQLite

class DatabaseTestViewController: UIViewController {

    var database: Connection!
    
    let usersTable = Table("users")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    let password = Expression<String>("password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    
    
    @IBAction func createTable() {
        print("CREATE TAPPED")
        
        let createTable = self.usersTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.email, unique: true)
            table.column(self.password)
        }
        
        do {
            try self.database.run(createTable)
        } catch {
            print(error)
        }
        
        print("Created Table")
    }
    
    @IBAction func insertUser() {
        print("INSERT TAPPED")
        let alert = UIAlertController(title: "Insert User", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Name" }
        alert.addTextField { (tf) in tf.placeholder = "Email" }
        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text,
                let email = alert.textFields?.last?.text
                else { return }
            print(name)
            print(email)
            
            let insertUser = self.usersTable.insert(self.name <- name, self.email <- email, self.password <- "nehari123")
            
            do {
                try self.database.run(insertUser)
                print("INSERTED USER")
            } catch {
                print(error)
            }
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func listUsers() {
        print("LIST TAPPED")
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                print("userId: \(user[self.id]), name: \(user[self.name]), email: \(user[self.email]), password: \(user[self.password])")
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func updateUser() {
        print("UPDATE TAPPED")
        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "User ID" }
        alert.addTextField { (tf) in tf.placeholder = "Email" }
        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            guard let userIdString = alert.textFields?.first?.text,
                let userId = Int(userIdString),
                let email = alert.textFields?.last?.text
                else { return }
            print(userIdString)
            print(email)
            
            let user = self.usersTable.filter(self.id == userId)
            let updateUser = user.update(self.email <- email)
            do {
                try self.database.run(updateUser)
            } catch {
                print(error)
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteUser() {
        print("DELETE TAPPED")
        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "User ID" }
        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            guard let userIdString = alert.textFields?.first?.text,
                let userId = Int(userIdString)
                else { return }
            print(userIdString)
            
            let user = self.usersTable.filter(self.id == userId)
            let deleteUser = user.delete()
            do {
                try self.database.run(deleteUser)
            } catch {
                print(error)
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
