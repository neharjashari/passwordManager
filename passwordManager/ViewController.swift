//
//  ViewController.swift
//  passwordManager
//
//  Created by Nehar Jashari on 7/9/19.
//  Copyright © 2019 Nehar Jashari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    // on click event for the Login Button
    @IBAction func onClickLogin(_ sender: UIButton) {
        // the sender is the object that called this method
        
    }
    
    // if don't have account go to sign up view to create one
    @IBAction func goToSignUp(_ sender: Any) {
        
    }
}

