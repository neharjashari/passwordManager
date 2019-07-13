//
//  SignUpViewViewController.swift
//  passwordManager
//
//  Created by Nehar Jashari on 7/9/19.
//  Copyright © 2019 Nehar Jashari. All rights reserved.
//

import UIKit
//import SQLite3

class SignUpViewViewController: UIViewController {

    //var db: OpaquePointer?

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func createAccount(_ sender: UIButton) {
        /*
        //getting values from textfields
        let fullnameDB = name.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let usernameDB = username.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailDB = email.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordDB = password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmPassword = confirmPass.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //validating that values are not empty
        if(fullnameDB?.isEmpty)!{
            name.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(usernameDB?.isEmpty)!{
            username.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(emailDB?.isEmpty)!{
            email.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(passwordDB?.isEmpty)!{
            password.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        // Confirm password validation
        if(confirmPassword != confirmPass.text){
            confirmPass.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        
        //creating a statement
        var stmt: OpaquePointer?
        
        //the insert query
        let queryString = "INSERT INTO Users (fullname, username, email, password) VALUES (?,?,?,?)"
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        //binding the parameters
        if sqlite3_bind_text(stmt, 1, fullnameDB, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, usernameDB, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, emailDB, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 4, passwordDB, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        //executing the query to insert values
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting hero: \(errmsg)")
            return
        }
        */
        
        let alert = UIAlertController(title: "Database", message: "Your account was created.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
}
