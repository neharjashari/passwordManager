//
//  ViewController.swift
//  passwordManager
//
//  Created by Nehar Jashari on 7/9/19.
//  Copyright © 2019 Nehar Jashari. All rights reserved.
//

import UIKit
import SQLite3


class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        
        
        let alert = UIAlertController(title: "Login", message: "You have logged in!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    // DB part

    
    
    
    
}

