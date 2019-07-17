//
//  ViewController.swift
//  passwordManager
//
//  Created by Nehar Jashari on 7/9/19.
//  Copyright © 2019 Nehar Jashari. All rights reserved.
//

import UIKit
import SQLite


class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
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
    
    // on click event for the Login Button
    @IBAction func onClickLogin(_ sender: UIButton) {
        // the sender is the object that called this method
        
        // do not make first responder either one of the text fields
        self.username.resignFirstResponder()
        self.password.resignFirstResponder()
        
        //getting values from textfields
        let usernameLogin = username.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordLogin = password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        print(usernameLogin!)
        print(passwordLogin!)
        
        do {
            for user in try self.database.prepare(usersTable) {
                if (user[emailCol] == usernameLogin && user[passwordCol] == passwordLogin) {
                    print("User logged.")
                    print("id: \(user[idCol]), email: \(user[emailCol]), password: \(user[passwordCol])")
                } else {
                    
                    let alert = UIAlertController(title: "Login", message: "The username or password you typed are not correct!", preferredStyle: .alert)
                     
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                     
                    self.present(alert, animated: true)
                }
            }
        } catch {
            print(error)
        }
        
    }
    

    
}

