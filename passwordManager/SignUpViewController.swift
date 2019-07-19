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
        
        passwordTextField.isSecureTextEntry = true
        confirmPassTextField.isSecureTextEntry = true
        
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
        let confirmPassword = confirmPassTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //validating that values are not empty
        if(fullnameDB?.isEmpty)!{
            fullnameTextField.layer.borderWidth = 1.0
            fullnameTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(emailDB?.isEmpty)!{
            emailTextField.layer.borderWidth = 1.0
            emailTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(passwordDB?.isEmpty)!{
            passwordTextField.layer.borderWidth = 1.0
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        // Confirm password validation
        if(confirmPassword != passwordDB){
            confirmPassTextField.layer.borderWidth = 1.0
            confirmPassTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
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
        
        // Alert
        let alert = UIAlertController(title: "Database", message: "Your account was created.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
        
    }

    
    @IBAction func listUsers(_ sender: UIButton) {
        print("LIST TAPPED")
        
        let alert = UIAlertController(title: "Admin", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Password" }
        let action = UIAlertAction(title: "List Users", style: .default) { (_) in
            guard let passwordAdmin = alert.textFields?.first?.text
                else { return }
            if passwordAdmin == "admin" {
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
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}
