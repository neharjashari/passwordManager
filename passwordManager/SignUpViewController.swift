//
//  SignUpViewController.swift
//  passwordManager
//
//  Created by Nehar Jashari on 7/13/19.
//  Copyright © 2019 Nehar Jashari. All rights reserved.
//

import UIKit
import SQLite

class SignUpViewController: UIViewController {

    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    var database: Connection!
    
    let usersTable = Table("users")
    let idCol = Expression<Int>("id")
    let nameCol = Expression<String>("name")
    let emailCol = Expression<String>("email")
    let passwordCol = Expression<String>("password")
    
    
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
        
        
        let createTable = self.usersTable.create { (table) in
            table.column(self.idCol, primaryKey: true)
            table.column(self.nameCol)
            table.column(self.emailCol, unique: true)
            table.column(self.passwordCol)
        }
        
        do {
            try self.database.run(createTable)
        } catch {
            print(error)
        }
        
        print("Created Table")
        
    }
    
    
    // Build in function for removing the keyboard after you click away from it
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func createAccount(_ sender: UIButton) {
        
        //getting values from textfields
        let fullnameDB = fullnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailDB = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordDB = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        print(fullnameDB!)
        print(emailDB!)
        print(passwordDB!)
        
        let insertUser = self.usersTable.insert(self.nameCol <- fullnameDB!, self.emailCol <- emailDB!, self.passwordCol <- passwordDB!)
        
        do {
            try self.database.run(insertUser)
            print("INSERTED USER")
        } catch {
            print(error)
        }
        
        
    }

    
    @IBAction func listUsers(_ sender: UIButton) {
        print("LIST TAPPED")
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                print("userId: \(user[self.idCol]), name: \(user[self.nameCol]), email: \(user[self.emailCol]), password: \(user[self.passwordCol])")
            }
        } catch {
            print(error)
        }
    }
    
}
